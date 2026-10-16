# Hyprland + Noctalia：macOS 风格桌面配置

面向 **Arch Linux + Hyprland + Noctalia Shell v5+** 的配置起点，目标是打造接近 macOS Sonoma / Sequoia 的顶部半透明面板、底部悬浮 Dock、应用启动器和统一的桌面观感。可选配置 Fcitx5 + Rime 中文输入法与简体中文 Locale。

> 本项目不使用 Niri 或 Waybar。Noctalia 负责 Shell 面板、Dock、启动器与快速设置，Hyprland 负责窗口管理。此仓库提供的是可审阅、可回滚的配置模板，并不承诺像素级复刻 macOS。

## 功能

- Hyprland Lua 配置：圆角、间距、动画、常用快捷键、截图和 Noctalia 自动启动。
- Noctalia v5+ TOML：顶部状态栏、半透明效果、底部 Dock、运行应用指示、鼠标悬停放大与自动隐藏。
- 可选 Fcitx5 + Rime 中文输入方案。
- 简体中文 Locale 和 CJK 字体配置指南。
- Arch Linux 安装、配置备份与恢复脚本。
- 脚本仅操作明确的目标文件，不删除无关配置。

## 兼容性

- Arch Linux rolling release。
- 推荐 Hyprland **0.55+**，使用 `hypr/hyprland.lua`。Hyprland 0.55 引入 Lua 配置并将旧 hyprlang 标记为弃用；旧配置在过渡期仍可能工作，但本项目不以旧语法为目标。
- 推荐 Noctalia **v5+**。Noctalia v4 是基于 Quickshell 的旧实现，配置和启动方式不同。
- 配置尚未在你的实际硬件上运行测试。安装前请阅读脚本并在登录会话中验证。

官方参考：
- [Noctalia 安装](https://docs.noctalia.dev/noctalia/getting-started/installation/)
- [Noctalia 启动](https://docs.noctalia.dev/noctalia/getting-started/running-the-shell/)
- [Noctalia 配置机制](https://docs.noctalia.dev/noctalia/configuration/)
- [Noctalia Bar](https://docs.noctalia.dev/noctalia/bar/)
- [Noctalia Dock](https://docs.noctalia.dev/noctalia/dock/)
- [Hyprland 0.55 发布说明](https://hypr.land/news/update55/)
- [ArchWiki：Fcitx5](https://wiki.archlinux.org/title/Fcitx5)

## 快速开始

克隆仓库：

```bash
git clone https://github.com/jerryliuxa/hyprland-noctalia-config.git
cd hyprland-noctalia-config
```

先检查包清单，再安装软件：

```bash
less scripts/packages-arch.txt
./scripts/install-arch.sh
```

安装 Hyprland 配置（会备份已存在的目标文件）：

```bash
./scripts/install-config.sh
```

安装 Noctalia 配置（同样会先备份已有配置）：

```bash
./scripts/install-noctalia-config.sh
```

然后登录 Hyprland 会话。Noctalia v5+ 通常使用 `noctalia` 命令；配置文件会由 Hyprland 启动事件调用 `noctalia --daemon`。首次运行后可执行：

```bash
noctalia config validate
```

如有错误，请按输出中的文件名、行号和设置名修正。Noctalia GUI 保存的覆盖项位于 `~/.local/state/noctalia/settings.toml`，优先级高于手写配置。

## 中文输入法（可选）

安装 Fcitx5、Rime 和中文字体：

```bash
sudo pacman -S --needed fcitx5 fcitx5-rime fcitx5-configtool \
  noto-fonts-cjk noto-fonts-emoji
```

Hyprland 配置会尝试启动 `fcitx5 -d`。在 `fcitx5-configtool` 中添加 Rime，并按需设置切换快捷键（默认通常为 Ctrl+Space）。Wayland 原生应用应优先使用 Wayland text-input 协议；不要无差别全局强制 GTK/Qt 输入法模块，只有特定应用异常时才按文档调整。

简体中文 Locale 配置见 [docs/chinese-input-and-locale.md](docs/chinese-input-and-locale.md)。Locale 不会自动翻译所有应用，是否显示中文取决于应用本身的翻译支持。

## 备份与恢复

- 配置安装脚本会在 `~/.config-backups/hyprland-noctalia-时间戳/` 创建备份。
- 使用 `scripts/restore-config.sh BACKUP_DIR` 恢复指定备份。
- 不会自动安装或启用登录管理器，也不会删除其他配置目录。
- 安装前请阅读脚本；软件包清单可按显卡、音频、输入法及现有桌面服务进行调整。

## 目录结构

```text
hyprland-noctalia-config/
├── hypr/hyprland.lua
├── noctalia/config.toml
├── input-method/environment.conf
├── localization/locale.conf.example
├── scripts/
│   ├── install-arch.sh
│   ├── install-config.sh
│   ├── install-noctalia-config.sh
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

## 许可证

MIT，见 [LICENSE](LICENSE)。
