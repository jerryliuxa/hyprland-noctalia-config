# 故障排查

## Noctalia 没有启动

```bash
command -v noctalia
noctalia
tail -n 200 ~/.cache/noctalia/noctalia.log
```

Noctalia v5+ 使用 `noctalia` 命令；旧版 v4 的 Quickshell 启动方法不同。不要混用两代配置。

## Noctalia 配置报错

```bash
noctalia config validate
noctalia config validate ~/.config/noctalia/config.toml
```

根据诊断中的文件、行号和 dotted key 修正。Noctalia 读取 `~/.config/noctalia/*.toml`，GUI 覆盖层 `~/.local/state/noctalia/settings.toml` 的优先级更高。

## Hyprland Lua 配置问题

确认版本：

```bash
hyprctl version
```

本仓库目标是 Hyprland 0.55+。从当前会话执行：

```bash
hyprctl configerrors
```

若你的版本较旧，先查阅对应版本的官方文档；不要把 Lua 配置直接粘贴进旧版 `hyprland.conf`。

## 中文输入没有反应

```bash
pgrep -a fcitx5
fcitx5-remote
fcitx5-diagnose
```

在 Fcitx5 配置工具中确认 Rime 已添加。Wayland 原生应用优先尝试原生 text-input；只有特定应用不工作时再添加 GTK/Qt IM 模块变量。重新登录可让用户会话环境变量生效。

## 中文显示为方框

```bash
fc-list :lang=zh family | sort -u | head -30
fc-cache -fv
```

安装 `noto-fonts-cjk`，并在应用内选择支持简体中文的字体。

## 模糊背景不生效

Noctalia 的 `compositor_blur` 需要合成器支持对应的 Wayland background-effect 协议。即使配置为 true，也不保证所有 Hyprland 版本/驱动都能呈现相同效果。可以先关闭模糊，确认面板透明度、层级和布局正常后再排查。

## 恢复配置

使用安装时打印的备份目录：

```bash
./scripts/restore-config.sh /path/to/hyprland-noctalia-backup
```

脚本只恢复指定备份中记录的 Hyprland 和/或 Noctalia 配置，不会回滚系统软件包。
