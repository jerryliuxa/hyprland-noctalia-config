# 安装指南

## 1. 前置条件

- Arch Linux 已更新，能正常联网。
- 已确认显卡驱动与 Wayland 工作正常。
- 建议先从 TTY 或备用会话测试，不要在尚未验证的配置上直接结束当前桌面会话。

## 2. 安装软件包

```bash
./scripts/install-arch.sh
```

脚本会列出包清单并要求确认。Noctalia v5+ 可从 Arch 官方仓库安装：

```bash
sudo pacman -S --needed noctalia
```

本项目不会自动启用或替换 SDDM、GDM 等登录管理器；保留当前系统的登录方式。

## 3. 安装配置

```bash
./scripts/install-config.sh
./scripts/install-noctalia-config.sh
```

两个脚本分别备份目标文件到 `~/.config-backups/hyprland-noctalia-时间戳/`。注意每次执行可能创建不同的备份目录，记下终端打印的路径。

## 4. 启动与验证

在 Hyprland 0.55+ 使用 `hyprland.lua`。从 TTY 启动的具体入口取决于你安装的 Hyprland 版本和登录管理器。登录后可以手动测试：

```bash
noctalia
noctalia config validate
hyprctl version
hyprctl configerrors
```

`hyprctl configerrors` 需在 Hyprland 会话中执行。若当前 Noctalia 的设置 UI 已保存相同选项，它们可能存储在 `~/.local/state/noctalia/settings.toml` 并覆盖手写 TOML。

## 5. 剪贴板历史（可选）

在仓库根目录执行：

~~~bash
./scripts/install-clipboard-history.sh
~~~

该功能使用 cliphist、wl-clipboard 和 Fuzzel，按 Super+V 打开搜索弹窗。详细用法、服务状态与隐私注意事项见 [剪贴板历史指南](clipboard-history.md)。

## 6. 主题微调

在 Noctalia 设置中调整 Bar、Dock、字体、主题与壁纸。推荐：
- 顶部 Bar：厚度约 32–36 px，暗色、透明度约 0.8，支持模糊时开启 compositor blur。
- Dock：底部、图标 44–52 px、悬停放大 1.35–1.5 倍、开启运行点和自动隐藏。
- Dock 的 `pinned` 使用桌面入口 ID，例如 `firefox`、`kitty`、`thunar`。如果占位图标出现，检查 `/usr/share/applications/` 中的 .desktop 文件。
- macOS 的应用菜单是应用集成能力；Linux 顶部 Bar 不会自动获得所有应用的全局菜单。

## 7. 回滚

找到安装脚本输出的备份路径：

```bash
ls -dt ~/.config-backups/hyprland-noctalia-*
```

然后把实际目录传给恢复脚本：

```bash
./scripts/restore-config.sh ~/.config-backups/hyprland-noctalia-YYYYMMDD-HHMMSS
```

只恢复该目录中存在备份或“原先不存在”标记的文件。不会删除其他目录。
