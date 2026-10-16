# Hyprland + Noctalia macOS-inspired desktop

A practical Arch Linux starter configuration for a macOS Sonoma/Sequoia-inspired Wayland desktop using **Hyprland + Noctalia Shell**, with optional Chinese input via Fcitx5 + Rime and Simplified Chinese locale support.

> This repository is a safe starter kit, not a promise of a pixel-perfect macOS clone. It does not use Niri or Waybar. Noctalia owns the shell bar, dock, launcher, and quick settings.

## Features

- Hyprland compositor configuration with rounded corners, gaps, animations, useful keybinds, screenshots, and Noctalia autostart.
- Noctalia v5+ configuration starter in TOML; tune Dock/Bar options from the Noctalia settings UI for the installed version.
- Optional Fcitx5 + Rime Chinese input setup for Wayland/XWayland.
- Simplified Chinese locale and CJK fonts guide.
- Install, backup, and restore scripts.
- No forced overwrite of existing configuration; installer backs up before installing templates.

## Compatibility

- Arch Linux (rolling release).
- Hyprland **0.55+** is recommended for the Lua configuration in `hypr/hyprland.lua`.
- Noctalia **v5+** is expected. Noctalia v4 is a different, legacy Quickshell-based implementation; its config and startup commands are not interchangeable.
- The scripts are conservative templates. Review them before running and test in a fresh user session.

Official references:
- [Noctalia installation](https://docs.noctalia.dev/noctalia/getting-started/installation/)
- [Noctalia running the shell](https://docs.noctalia.dev/noctalia/getting-started/running-the-shell/)
- [Noctalia configuration](https://docs.noctalia.dev/noctalia/configuration/)
- [Hyprland 0.55 release notes](https://hypr.land/news/update55/)
- [ArchWiki: Fcitx5](https://wiki.archlinux.org/title/Fcitx5)

## Quick start

Clone the repository:

```bash
git clone https://github.com/jerryliuxa/hyprland-noctalia-config.git
cd hyprland-noctalia-config
```

Review the package list, then install packages:

```bash
less scripts/packages-arch.txt
./scripts/install-arch.sh
```

Back up your current configs and install the Hyprland starter:

```bash
./scripts/install-config.sh
```

The script installs `hypr/hyprland.lua` to `~/.config/hypr/hyprland.lua` only after backing up any existing file. It does **not** overwrite a pre-existing Noctalia configuration; copy the example manually after backing up and review it first:

```bash
mkdir -p ~/.config/noctalia
cp noctalia/config.toml ~/.config/noctalia/config.toml.example
```

Noctalia reads TOML configuration from `~/.config/noctalia/`. To avoid version-specific option errors, use the Noctalia settings UI to configure Bar and Dock, then consult the installed version's documentation before copying example options into your live config.

## Start Noctalia

For Noctalia v5+, the executable is normally `noctalia`. The provided Hyprland Lua config starts it using `noctalia --daemon`. To debug manually from a terminal:

```bash
noctalia
```

Logs are normally under `~/.cache/noctalia/noctalia.log`.

## Chinese input (optional)

Install Fcitx5 + Rime and CJK fonts:

```bash
sudo pacman -S --needed fcitx5 fcitx5-rime fcitx5-configtool \
  noto-fonts-cjk noto-fonts-emoji
```

The Hyprland starter sets `XMODIFIERS=@im=fcitx` and starts `fcitx5 -d`. Native Wayland apps should normally use the Wayland text-input protocol; do not globally force GTK/Qt IM modules unless a particular application needs it. Use `fcitx5-configtool` to add Rime and choose a keyboard layout. Press Ctrl+Space to switch input methods (unless changed in settings).

For Simplified Chinese messages/formatting, enable `zh_CN.UTF-8 UTF-8` in `/etc/locale.gen`, run `sudo locale-gen`, and choose locale settings as described in [docs/chinese-input-and-locale.md](docs/chinese-input-and-locale.md). Locale changes do not automatically translate every app; translation depends on each app's language support.

## Install / rollback safety

- `scripts/install-config.sh` creates a timestamped backup under `~/.config-backups/hyprland-noctalia-*/`.
- `scripts/restore-config.sh BACKUP_DIR` restores the saved Hyprland and Noctalia paths from a backup.
- No script removes unrelated config folders or installs a login manager automatically.
- Inspect scripts before running them; adjust the package list to your hardware and existing system.

## Layout

```text
hyprland-noctalia-config/
├── hypr/hyprland.lua
├── noctalia/config.toml
├── input-method/environment.conf
├── localization/locale.conf.example
├── scripts/
│   ├── install-arch.sh
│   ├── install-config.sh
│   ├── restore-config.sh
│   └── packages-arch.txt
├── docs/
│   ├── installation.md
│   ├── chinese-input-and-locale.md
│   └── troubleshooting.md
├── README.md
├── README.en.md
├── LICENSE
└── .gitignore
```

## License

MIT. See [LICENSE](LICENSE).
