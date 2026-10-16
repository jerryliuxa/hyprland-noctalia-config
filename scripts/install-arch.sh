#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PACKAGE_FILE="$SCRIPT_DIR/packages-arch.txt"

if [[ ! -f "$PACKAGE_FILE" ]]; then
  echo "Missing package list: $PACKAGE_FILE" >&2
  exit 1
fi
if ! command -v pacman >/dev/null 2>&1; then
  echo "This installer is intended for Arch Linux (pacman not found)." >&2
  exit 1
fi

mapfile -t packages < <(grep -Ev '^[[:space:]]*(#|$)' "$PACKAGE_FILE")
if (("${#packages[@]}" == 0)); then
  echo "No packages listed in $PACKAGE_FILE" >&2
  exit 1
fi

printf 'Packages to install:\n'
printf '  %s\n' "${packages[@]}"
printf '\nReview the list above. Continue? [y/N] '
read -r answer
[[ "$answer" =~ ^[Yy]$ ]] || { echo "Cancelled."; exit 0; }

sudo pacman -S --needed "${packages[@]}"
