#!/usr/bin/env bash
# Developer: Hamdy Abou El Anein
# Contact: hamdy.aea@protonmail.com
# Copyright (C) 2026 Hamdy Abou El Anein
# SPDX-License-Identifier: GPL-3.0-or-later
# Demonstrate that repeated lossless compression cannot shrink every input.
set -euo pipefail

usage() {
    printf 'Usage: %s [--output NEW_DIRECTORY] [--rounds N]\n' "${0##*/}"
}
rounds=100
output=''
while (( $# )); do
    case "$1" in
        --output)
            (( $# >= 2 )) || { usage >&2; exit 2; }
            output=$2
            shift 2
            ;;
        --rounds)
            (( $# >= 2 )) || { usage >&2; exit 2; }
            rounds=$2
            shift 2
            ;;
        --help|-h)
            usage
            exit 0
            ;;
        *)
            usage >&2
            exit 2
            ;;
    esac
done
if [[ ! "$rounds" =~ ^[0-9]+$ ]] || (( 10#$rounds < 1 || 10#$rounds > 1000 )); then
    printf 'Error: --rounds must be 1–1000.\n' >&2
    exit 2
fi
rounds=$((10#$rounds))
if [[ -z "$output" ]]; then
    output=$(mktemp -d "${TMPDIR:-/tmp}/paradox-gzip-XXXXXXXX")
else
    # Never overwrite an existing file or directory, even if it is empty.
    if [[ -e "$output" ]]; then
        printf 'Error: output already exists: %s\n' "$output" >&2
        exit 2
    fi
    mkdir -- "$output"
fi

input=$(printf '%s/toto%03d' "$output" 1)
for (( i = 0; i < 100; i++ )); do
    printf 'blabla\n' >> "$input"
done
for (( i = 1; i <= rounds; i++ )); do
    current=$(printf '%s/toto%03d' "$output" "$i")
    next=$(printf '%s/toto%03d' "$output" "$((i + 1))")
    gzip -n -c -- "$current" > "$next"
done
printf 'Output directory: %s\n' "$output"
printf 'Round  Bytes\n'
for (( i = 1; i <= rounds + 1; i++ )); do
    current=$(printf '%s/toto%03d' "$output" "$i")
    printf '%5d  %s\n' "$((i - 1))" "$(wc -c < "$current")"
done
