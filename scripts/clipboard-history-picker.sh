#!/usr/bin/env bash
set -euo pipefail

# Show searchable clipboard history in Fuzzel, then copy the selected entry.
# Canceling the menu leaves the current clipboard unchanged.
for cmd in cliphist fuzzel wl-copy; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    notify-send "Clipboard history" "Missing $cmd; install the project packages first." 2>/dev/null || true
    exit 1
  fi
done

selection="$(cliphist list | fuzzel --dmenu --prompt='Clipboard › ' --width=80 --lines=12)" || exit 0
[[ -n "$selection" ]] || exit 0
printf '%s' "$selection" | cliphist decode | wl-copy
