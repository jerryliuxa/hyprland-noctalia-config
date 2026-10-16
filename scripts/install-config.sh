#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"
SOURCE="$REPO_ROOT/hypr/hyprland.lua"
TARGET_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/hypr"
TARGET="$TARGET_DIR/hyprland.lua"
BACKUP_ROOT="$HOME/.config-backups"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP="$BACKUP_ROOT/hyprland-noctalia-$STAMP"

[[ -f "$SOURCE" ]] || { echo "Missing source config: $SOURCE" >&2; exit 1; }
mkdir -p "$TARGET_DIR" "$BACKUP_ROOT"

if [[ -e "$TARGET" || -L "$TARGET" ]]; then
  mkdir -p "$BACKUP/hypr"
  cp -a "$TARGET" "$BACKUP/hypr/hyprland.lua"
  echo "Backed up existing config to $BACKUP/hypr/hyprland.lua"
else
  mkdir -p "$BACKUP"
  touch "$BACKUP/.absent-hyprland-lua"
fi

install -m 0644 "$SOURCE" "$TARGET"
echo "Installed: $TARGET"
echo "Backup directory: $BACKUP"
echo "Review the config and validate with your installed Hyprland version before logging out."
