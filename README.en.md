# Hyprland + Noctalia macOS-inspired desktop

Arch Linux starter configuration for a macOS Sonoma/Sequoia-inspired desktop using **Hyprland + Noctalia Shell v5+**. Includes an optional Fcitx5 + Rime Chinese input setup and Simplified Chinese locale guide.

This project does not use Niri or Waybar. Noctalia owns the shell bar, dock, launcher, and quick settings; Hyprland handles window management.

## Quick start

```bash
git clone https://github.com/jerryliuxa/hyprland-noctalia-config.git
cd hyprland-noctalia-config
less scripts/packages-arch.txt
./scripts/install-arch.sh
./scripts/install-config.sh
./scripts/install-noctalia-config.sh
```

The scripts back up existing target files under `~/.config-backups/`. Review scripts and config files before running. The project targets Hyprland 0.55+ Lua configuration and Noctalia v5+; older versions use different configuration/startup conventions.

Validate Noctalia after installation:

```bash
noctalia config validate
```

See [README.md](README.md) for the full Simplified Chinese guide, [installation](docs/installation.md), [Chinese input and locale](docs/chinese-input-and-locale.md), and [troubleshooting](docs/troubleshooting.md).

Official docs:
- https://docs.noctalia.dev/noctalia/getting-started/installation/
- https://docs.noctalia.dev/noctalia/configuration/
- https://docs.noctalia.dev/noctalia/bar/
- https://docs.noctalia.dev/noctalia/dock/
- https://hypr.land/news/update55/

MIT License.
