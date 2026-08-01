#!/bin/bash
#
# Mimics "rpm-ostree status" on traditional (non-atomic) Fedora.
# Shows packages installed beyond the default OS, removed base
# packages, and locally-installed RPMs.

set -euo pipefail

BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

# Packages to exclude from "layered" output — these get reason "user"
# through normal OS operations (kernel updates, etc.), not explicit install.
NOISE_PATTERNS=(
    '^kernel'
    '^gpg-pubkey$'
    '^fedora-release'
    '^generic-release'
)

build_noise_filter() {
    local pattern
    pattern=$(printf '%s\n' "${NOISE_PATTERNS[@]}" | paste -sd'|')
    echo "$pattern"
}

show_layered() {
    local noise_filter
    noise_filter=$(build_noise_filter)

    local pkgs
    pkgs=$(dnf repoquery --userinstalled --queryformat '%{name}\n' 2>/dev/null \
        | grep -Ev "$noise_filter" \
        | sort -u)

    if [[ -n "$pkgs" ]]; then
        printf "${BOLD}%s${RESET}\n" "LayeredPackages:"
        echo "$pkgs" | while read -r pkg; do
            echo "  $pkg"
        done
    else
        printf "${DIM}No layered packages.${RESET}\n"
    fi
}

show_local() {
    local installed available local_names local_pkgs
    installed=$(rpm -qa --qf '%{name}\n' | sort -u)
    available=$(dnf repoquery --available --queryformat '%{name}\n' 2>/dev/null | sort -u)

    # Package names installed but not available in any enabled repo
    local_names=$(comm -23 <(echo "$installed") <(echo "$available") \
        | grep -Ev '^gpg-pubkey' \
        | sort -u)

    # Re-query with full NEVRA for display
    local_pkgs=""
    if [[ -n "$local_names" ]]; then
        local_pkgs=$(echo "$local_names" | while read -r name; do
            rpm -q --qf '%{name}-%{version}-%{release}.%{arch}\n' "$name" 2>/dev/null
        done | sort -u)
    fi

    if [[ -n "$local_pkgs" ]]; then
        printf "${BOLD}%s${RESET}\n" "LocalPackages:"
        echo "$local_pkgs" | while read -r pkg; do
            echo "  $pkg"
        done
    else
        printf "${DIM}No local packages.${RESET}\n"
    fi
}

show_removed() {
    local group_pkgs installed removed

    # Collect mandatory+default packages from all installed groups.
    # dnf5 group info format: "Default packages   : pkg-name"
    #                         "                    : pkg-name"
    group_pkgs=$(dnf group info --installed '*' 2>/dev/null \
        | awk -F': ' '
            /^(Mandatory|Default) packages/ { section=1; if (NF>1) print $2; next }
            /^Optional packages/            { section=0; next }
            /^[A-Z]/                        { section=0; next }
            section && /: / { print $2 }
        ' \
        | sort -u)

    if [[ -z "$group_pkgs" ]]; then
        return
    fi

    installed=$(rpm -qa --qf '%{name}\n' | sort -u)
    removed=$(comm -23 <(echo "$group_pkgs") <(echo "$installed"))

    if [[ -n "$removed" ]]; then
        printf "${BOLD}%s${RESET}\n" "RemovedBasePackages:"
        echo "$removed" | while read -r pkg; do
            echo "  $pkg"
        done
    fi
}

main() {
    printf "${BOLD}%-20s${RESET} %s\n" "OS:" "$(source /etc/os-release && echo "$PRETTY_NAME")"
    printf "${BOLD}%-20s${RESET} %s\n" "Kernel:" "$(uname -r)"
    echo ""

    show_layered
    echo ""
    show_removed
    echo ""
    show_local
}

main "$@"
