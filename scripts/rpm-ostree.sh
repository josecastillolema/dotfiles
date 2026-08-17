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

get_group_pkgs() {
    dnf group info --installed '*' 2>/dev/null \
        | awk -F': ' '
            /^(Mandatory|Default) packages/ { section=1; if (NF>1) print $2; next }
            /^Optional packages/            { section=0; next }
            /^[A-Z]/                        { section=0; next }
            section && /: / { print $2 }
        ' \
        | sort -u
}

categorize_repo() {
    local repo="$1"
    case "$repo" in
        csb-*|*csb-fedora|*csb-fedora-*)  echo "CSB (Enterprise)" ;;
        @commandline)                      echo "Local RPMs" ;;
        fedora|fedora-*|updates|updates-*) echo "Fedora" ;;
        *)                                 echo "Third-party ($repo)" ;;
    esac
}

show_layered() {
    local noise_filter
    noise_filter=$(build_noise_filter)

    local group_pkgs userinstalled pkgs
    group_pkgs=$(get_group_pkgs)
    userinstalled=$(dnf repoquery --userinstalled --queryformat '%{name}
' 2>/dev/null \
        | grep -Ev "$noise_filter" \
        | sort -u)

    if [[ -n "$group_pkgs" ]]; then
        pkgs=$(comm -23 <(echo "$userinstalled") <(echo "$group_pkgs"))
    else
        pkgs="$userinstalled"
    fi

    if [[ -z "$pkgs" ]]; then
        printf "${DIM}No layered packages.${RESET}\n"
        return
    fi

    # Batch query: build name-to-repo lookup in one call
    declare -A repo_of
    while IFS='|' read -r name repo; do
        [[ -n "$name" ]] && repo_of["$name"]="$repo"
    done < <(dnf repoquery --installed --queryformat '%{name}|%{from_repo}
' 2>/dev/null)

    # Build categorized lists
    declare -A categories
    while read -r pkg; do
        local category
        category=$(categorize_repo "${repo_of[$pkg]:-}")
        categories["$category"]+="  $pkg"$'\n'
    done <<< "$pkgs"

    # Print grouped by category
    local first=true
    for category in "Fedora" "CSB (Enterprise)" "Local RPMs"; do
        [[ -z "${categories[$category]:-}" ]] && continue
        $first || echo ""
        first=false
        printf "${BOLD}LayeredPackages ${DIM}(%s)${RESET}${BOLD}:${RESET}\n" "$category"
        echo -n "${categories[$category]}"
    done

    # Print any third-party categories
    for category in "${!categories[@]}"; do
        case "$category" in
            Fedora|"CSB (Enterprise)"|"Local RPMs") continue ;;
        esac
        $first || echo ""
        first=false
        printf "${BOLD}LayeredPackages ${DIM}(%s)${RESET}${BOLD}:${RESET}\n" "$category"
        echo -n "${categories[$category]}"
    done
}

show_local() {
    local installed available local_names local_pkgs
    installed=$(rpm -qa --qf '%{name}\n' | sort -u)
    available=$(dnf repoquery --available --queryformat '%{name}
' 2>/dev/null | sort -u)

    # Package names installed but not available in any enabled repo
    local_names=$(comm -23 <(echo "$installed") <(echo "$available") \
        | grep -Ev '^gpg-pubkey' \
        | sort -u || true)

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

    group_pkgs=$(get_group_pkgs)

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
