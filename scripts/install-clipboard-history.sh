#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"
BIN_DIR="$HOME/.local/bin"
SERVICE_DIR="$HOME/.config/systemd/user"

for cmd in systemctl wl-paste wl-copy cliphist fuzzel; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Missing command: $cmd" >&2
    echo "Install the project packages first: ./scripts/install-arch.sh" >&2
    exit 1
  fi
done

install -d "$BIN_DIR" "$SERVICE_DIR"
install -m 0755 "$SCRIPT_DIR/clipboard-history-picker.sh" "$BIN_DIR/clipboard-history-picker"
install -m 0644 "$REPO_DIR/systemd/user/cliphist-text.service" "$SERVICE_DIR/cliphist-text.service"
install -m 0644 "$REPO_DIR/systemd/user/cliphist-image.service" "$SERVICE_DIR/cliphist-image.service"

systemctl --user daemon-reload
systemctl --user enable --now cliphist-text.service cliphist-image.service

echo "Clipboard history installed."
echo "Use Super+V in Hyprland to search clipboard history."
echo "Check services with: systemctl --user --no-pager status cliphist-text cliphist-image"
