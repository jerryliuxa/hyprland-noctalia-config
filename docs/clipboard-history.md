# 剪贴板历史（cliphist + wl-clipboard）

本方案面向 Arch Linux + Hyprland + Noctalia v5+，不依赖旧版 Quickshell IPC。剪贴板历史使用 cliphist 保存，wl-paste 监听 Wayland 剪贴板，fuzzel 提供可搜索的选择弹窗。按 Super+V 选择一条记录后，该内容会写回系统剪贴板，可在任意应用中粘贴。

## 安装

在仓库根目录执行：

~~~bash
./scripts/install-arch.sh
./scripts/install-config.sh
./scripts/install-noctalia-config.sh
./scripts/install-clipboard-history.sh
~~~

如果不想重跑全部安装步骤，确认已安装 cliphist、wl-clipboard、fuzzel 后，只需运行最后一条命令。

安装脚本会把选择器放在 ~/.local/bin/clipboard-history-picker，并安装两个 systemd 用户服务：一个记录文本，一个记录图片。服务在用户会话中运行。

## 使用

- 按 Super+V 打开剪贴板历史。
- 输入关键字筛选；用方向键选择，按 Enter 复制选中项。
- 回到目标应用按 Ctrl+V 粘贴。
- 取消选择不会更改当前剪贴板。

## 验证与排错

~~~bash
systemctl --user status cliphist-text.service cliphist-image.service
cliphist list
~~~

如果历史为空，先复制一段普通文本，再检查服务状态。Wayland 监听器必须在 Hyprland 图形会话内运行；如果刚安装服务时没有图形会话，请重新登录或手动启动服务。

如果图片记录不能恢复，可先确认剪贴板源应用确实提供了 image MIME 类型。不同应用对图片剪贴板格式的支持可能不同。

## 隐私说明

剪贴板历史可能保存密码、访问令牌、个人资料等敏感数据。请勿复制敏感信息到历史记录，或定期清理历史。清理所有条目：

~~~bash
cliphist wipe
~~~

清理操作不可撤销。剪贴板历史存储在用户本地，不会自动同步到云端。

## 手动操作

~~~bash
# 查看记录
cliphist list

# 清空历史
cliphist wipe

# 重启监听服务
systemctl --user restart cliphist-text.service cliphist-image.service
~~~
