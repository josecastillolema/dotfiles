#!/usr/bin/env python3
#
# Copies Google auth cookies from an authenticated Ferdium partition to
# target partitions (e.g. Google Calendar, Gemini) that cannot log in on
# their own because Google blocks sign-in from embedded browsers.
#
# Related Ferdium issues:
#   https://github.com/ferdium/ferdium-app/issues/639
#   https://github.com/ferdium/ferdium-app/issues/1064
#   https://github.com/ferdium/ferdium-app/issues/2273
#
# Usage:
#   1. Close Ferdium
#   2. Run: python3 copy-google-cookies.py
#   3. Reopen Ferdium
#
# To find the right partition UUIDs, run with --list to see which
# partitions have Google auth cookies and what hosts they contain.

import sqlite3
import argparse
import os
import sys

BASE = os.path.expanduser(
    "~/.var/app/org.ferdium.Ferdium/config/Ferdium/Partitions"
)

SOURCE = "service-77f32aa7-2cba-436f-a80c-a2eebfe0faf1"  # Google Gmail
TARGETS = [
    "service-b5e28255-d21f-4eeb-a2da-b9f081808215",  # Google Calendar
    "service-92ddb96e-f013-4afd-82e9-ac24bfe9dbc4",  # Google Gemini
]

HOSTS_TO_COPY = (".google.com", ".google.es", "accounts.google.com")


def list_partitions():
    for entry in sorted(os.listdir(BASE)):
        cookie_path = os.path.join(BASE, entry, "Cookies")
        if not os.path.isfile(cookie_path):
            print(f"{entry}  (no cookies)")
            continue
        try:
            conn = sqlite3.connect(cookie_path)
            c = conn.cursor()
            c.execute(
                "SELECT name FROM cookies "
                "WHERE name='SID' AND host_key='.google.com' LIMIT 1"
            )
            has_sid = "HAS_SID" if c.fetchone() else "no_sid"
            c.execute(
                "SELECT DISTINCT host_key FROM cookies "
                "WHERE host_key LIKE '%google%' ORDER BY host_key"
            )
            hosts = [r[0] for r in c.fetchall()]
            conn.close()
            print(f"{entry}  {has_sid}  {hosts}")
        except Exception as e:
            print(f"{entry}  error: {e}")


def copy_cookies():
    source_path = os.path.join(BASE, SOURCE, "Cookies")
    if not os.path.isfile(source_path):
        print(f"Source cookies not found: {source_path}")
        sys.exit(1)

    conn = sqlite3.connect(source_path)
    c = conn.cursor()
    c.execute("PRAGMA table_info(cookies)")
    columns = [col[1] for col in c.fetchall()]

    placeholders_str = ",".join(["?" for _ in columns])
    host_placeholders = ",".join(["?" for _ in HOSTS_TO_COPY])

    c.execute(
        f"SELECT * FROM cookies WHERE host_key IN ({host_placeholders})",
        HOSTS_TO_COPY,
    )
    auth_cookies = c.fetchall()
    conn.close()

    if not auth_cookies:
        print("No auth cookies found in source partition!")
        print("Make sure Gmail is still logged in and try again.")
        sys.exit(1)

    name_idx = columns.index("name")
    host_idx = columns.index("host_key")
    print(f"Found {len(auth_cookies)} cookies to copy:")
    for cookie in auth_cookies:
        print(f"  {cookie[name_idx]} @ {cookie[host_idx]}")

    for target_id in TARGETS:
        target_path = os.path.join(BASE, target_id, "Cookies")
        if not os.path.isfile(target_path):
            print(f"\nTarget not found: {target_path} — skipping")
            continue

        print(f"\nCopying to {target_id}...")
        tgt_conn = sqlite3.connect(target_path)
        tgt_c = tgt_conn.cursor()

        tgt_c.execute(
            f"DELETE FROM cookies WHERE host_key IN ({host_placeholders})",
            HOSTS_TO_COPY,
        )
        print(f"  Deleted {tgt_c.rowcount} existing cookies")

        tgt_c.executemany(
            f"INSERT INTO cookies VALUES ({placeholders_str})", auth_cookies
        )
        print(f"  Inserted {len(auth_cookies)} cookies")

        tgt_conn.commit()
        tgt_conn.close()

    print("\nDone! Start Ferdium and check Calendar/Gemini.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Copy Google auth cookies between Ferdium partitions"
    )
    parser.add_argument(
        "--list",
        action="store_true",
        help="List all partitions and their Google cookie status",
    )
    args = parser.parse_args()

    if args.list:
        list_partitions()
    else:
        copy_cookies()
