#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"
SOURCE="$REPO_ROOT/noctalia/config.toml"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
TARGET_DIR="$CONFIG_HOME/noctalia"
TARGET="$TARGET_DIR/config.toml"
BACKUP_ROOT="$HOME/.config-backups"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP="$BACKUP_ROOT/hyprland-noctalia-$STAMP"

[[ -f "$SOURCE" ]] || { echo "Missing source config: $SOURCE" >&2; exit 1; }
mkdir -p "$TARGET_DIR" "$BACKUP_ROOT"

if [[ -e "$TARGET" || -L "$TARGET" ]]; then
  mkdir -p "$BACKUP/noctalia"
  cp -a "$TARGET" "$BACKUP/noctalia/config.toml"
  echo "Backed up existing config to $BACKUP/noctalia/config.toml"
else
  mkdir -p "$BACKUP"
  touch "$BACKUP/.absent-noctalia-config"
fi

install -m 0644 "$SOURCE" "$TARGET"
echo "Installed: $TARGET"
echo "Backup directory: $BACKUP"
if command -v noctalia >/dev/null 2>&1; then
  echo "Validating Noctalia configuration..."
  noctalia config validate "$TARGET"
else
  echo "Noctalia command not found; install package 'noctalia' before validation."
fi
