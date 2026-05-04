#!/bin/bash

if [ $# -eq 0 ]; then
    exec imv
fi

if [ $# -ge 2 ]; then
    exec imv "$@"
fi

target="$(realpath "$1")"
dir="$(dirname "$target")"

sort_column=$(gio info -a "metadata::thunar-sort-column" "$dir" 2>/dev/null \
    | grep "thunar-sort-column" | sed 's/.*: //')
if [ -z "$sort_column" ]; then
    sort_column=$(xfconf-query -c thunar -p /last-sort-column 2>/dev/null)
fi
sort_column="${sort_column:-THUNAR_COLUMN_NAME}"

sort_order=$(gio info -a "metadata::thunar-sort-order" "$dir" 2>/dev/null \
    | grep "thunar-sort-order" | sed 's/.*: //')
if [ -z "$sort_order" ]; then
    sort_order=$(xfconf-query -c thunar -p /last-sort-order 2>/dev/null)
fi
sort_order="${sort_order:-GTK_SORT_ASCENDING}"

rev=""
sort_flags="n"
if [ "$sort_order" = "GTK_SORT_DESCENDING" ]; then
    rev="-r"
    sort_flags="nr"
fi

find_images() {
    find "$dir" -maxdepth 1 -not -name '.*' \( \
        -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \
        -o -iname '*.gif' -o -iname '*.bmp' -o -iname '*.tiff' \
        -o -iname '*.tif' -o -iname '*.svg' -o -iname '*.webp' \
        -o -iname '*.avif' -o -iname '*.heif' -o -iname '*.heic' \
        -o -iname '*.jxl' -o -iname '*.qoi' -o -iname '*.ff' \
    \) -print0
}

files=()

case "$sort_column" in
    THUNAR_COLUMN_NAME)
        while IFS= read -r -d '' f; do
            files+=("$f")
        done < <(find_images | sort -z -fV $rev)
        ;;
    THUNAR_COLUMN_DATE_MODIFIED)
        while IFS=$'\t' read -r _ f; do
            files+=("$f")
        done < <(find_images | xargs -0 stat --format=$'%Y\t%n' | sort -t$'\t' -k1,1${sort_flags})
        ;;
    THUNAR_COLUMN_DATE_CREATED)
        while IFS=$'\t' read -r _ f; do
            files+=("$f")
        done < <(find_images | xargs -0 stat --format=$'%W\t%n' | sort -t$'\t' -k1,1${sort_flags})
        ;;
    THUNAR_COLUMN_SIZE)
        while IFS=$'\t' read -r _ f; do
            files+=("$f")
        done < <(find_images | xargs -0 stat --format=$'%s\t%n' | sort -t$'\t' -k1,1${sort_flags})
        ;;
    *)
        while IFS= read -r -d '' f; do
            files+=("$f")
        done < <(find_images | sort -z -fV $rev)
        ;;
esac

exec imv -n "$target" "${files[@]}"
