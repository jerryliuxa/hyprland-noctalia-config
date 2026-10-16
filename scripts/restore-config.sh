#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 BACKUP_DIR" >&2
  echo "Example: $0 ~/.config-backups/hyprland-noctalia-20261016-120000" >&2
  exit 2
fi

BACKUP="$(realpath -m -- "$1")"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
RESTORED=0

if [[ -f "$BACKUP/hypr/hyprland.lua" ]]; then
  mkdir -p "$CONFIG_HOME/hypr"
  cp -a "$BACKUP/hypr/hyprland.lua" "$CONFIG_HOME/hypr/hyprland.lua"
  echo "Restored Hyprland config."
  RESTORED=1
elif [[ -f "$BACKUP/.absent-hyprland-lua" ]]; then
  rm -f "$CONFIG_HOME/hypr/hyprland.lua"
  echo "Removed installed Hyprland template (there was no prior file)."
  RESTORED=1
fi

if [[ -f "$BACKUP/noctalia/config.toml" ]]; then
  mkdir -p "$CONFIG_HOME/noctalia"
  cp -a "$BACKUP/noctalia/config.toml" "$CONFIG_HOME/noctalia/config.toml"
  echo "Restored Noctalia config."
  RESTORED=1
elif [[ -f "$BACKUP/.absent-noctalia-config" ]]; then
  rm -f "$CONFIG_HOME/noctalia/config.toml"
  echo "Removed installed Noctalia template (there was no prior file)."
  RESTORED=1
fi

if (( RESTORED == 0 )); then
  echo "No recognized config backup files found in: $BACKUP" >&2
  exit 1
fi
echo "Restore complete. Restart or reload the relevant component if needed."
