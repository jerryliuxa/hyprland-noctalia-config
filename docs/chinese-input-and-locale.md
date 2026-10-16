# 中文输入法与简体中文界面

本项目使用 Fcitx5 + Rime。输入法、系统 Locale、字体与应用翻译是不同层次，需要分别设置。

## 1. 安装

```bash
sudo pacman -S --needed fcitx5 fcitx5-rime fcitx5-configtool \
  fcitx5-gtk fcitx5-qt noto-fonts-cjk noto-fonts-emoji
```

在 `fcitx5-configtool` 中添加 Rime / 中州韵，并按需配置拼音、双拼和词库。Ctrl+Space 通常用于切换输入法，可在设置中修改。

Hyprland Lua 配置会在会话启动时尝试运行 `fcitx5 -d`（未安装时会跳过）。

## 2. Wayland 环境变量

Wayland 原生应用应优先使用 Wayland text-input 协议。不要一开始就把 `GTK_IM_MODULE=fcitx` 和 `QT_IM_MODULE=fcitx` 全局强制应用到所有原生 Wayland 应用；这可能导致部分应用的预编辑或输入弹窗异常。

对确实需要 IM 模块的 XWayland / 特定 GTK/Qt 应用，可按需设置：
- `XMODIFIERS=@im=fcitx`
- `GTK_IM_MODULE=fcitx`
- `QT_IM_MODULE=fcitx`

示例见 `input-method/environment.conf`。它是参考文件，不会自动被系统读取。优先为有问题的应用单独设置环境变量，而不是不加区分地全局设置。

## 3. 生成中文 Locale

编辑 `/etc/locale.gen`，确保启用：

```text
en_US.UTF-8 UTF-8
zh_CN.UTF-8 UTF-8
```

然后运行：

```bash
sudo locale-gen
locale -a | grep -Ei 'en_US.utf8|zh_CN.utf8'
```

可以将 `localization/locale.conf.example` 的内容作为 `/etc/locale.conf` 示例。混合设置示例：

```ini
LANG=en_US.UTF-8
LC_MESSAGES=zh_CN.UTF-8
LC_TIME=zh_CN.UTF-8
```

如希望整个会话使用简体中文，可考虑 `LANG=zh_CN.UTF-8`。修改后注销并重新登录。不要在 Locale 尚未生成时就引用它。

## 4. 中文字体

```bash
sudo pacman -S --needed noto-fonts-cjk noto-fonts-emoji
fc-cache -fv
fc-list :lang=zh family | sort -u | head
```

如果中文仍显示方框，检查应用是否使用了支持 CJK 的字体。

## 5. 验证

```bash
fcitx5-remote
pgrep -a fcitx5
fcitx5-diagnose
locale
```

打开 Kitty 或浏览器，在输入框中按 Ctrl+Space 并输入拼音。原生 Wayland 应用与 XWayland 应用的行为可能不同，应分开排查。

## 6. 中文界面限制

Locale 只会让支持相应翻译的应用切换语言，不会自动翻译所有应用。Noctalia、浏览器、文件管理器及其他应用的简体中文覆盖程度取决于各自版本和翻译包。
