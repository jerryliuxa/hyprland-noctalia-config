-- Hyprland 0.55+ Lua configuration
-- macOS Sonoma / Sequoia-inspired desktop with Noctalia Shell.
-- Review monitor, keyboard, and hardware-specific settings before use.

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        layout = "dwindle",
    },
    decoration = {
        rounding = 14,
        active_opacity = 1.0,
        inactive_opacity = 0.96,
        shadow = {
            enabled = true,
            range = 6,
            render_power = 3,
            color = 0xee101018,
        },
        blur = {
            enabled = true,
            size = 5,
            passes = 3,
            vibrancy = 0.12,
        },
    },
    animations = {
        enabled = true,
    },
})

-- Core launchers
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("kitty"), {
    description = "Open terminal",
})
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"), {
    description = "Open Noctalia launcher",
})
hl.bind("SUPER + V", hl.dsp.exec_cmd("~/.local/bin/clipboard-history-picker"), {
    description = "Search clipboard history",
})
hl.bind("SUPER + S", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center"), {
    description = "Toggle Noctalia Control Center",
})
hl.bind("SUPER + COMMA", hl.dsp.exec_cmd("noctalia msg settings-toggle"), {
    description = "Open Noctalia settings",
})
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("noctalia msg screenshot-region"), {
    description = "Capture screen region",
})
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"), {
    description = "Lock screen",
})

-- Audio controls routed through Noctalia IPC
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("noctalia msg volume-up"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("noctalia msg volume-down"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("noctalia msg volume-mute"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })

-- Start Noctalia and (if installed) Fcitx5 at compositor startup.
hl.on("hyprland.start", function()
    hl.exec_cmd("noctalia --daemon")
    hl.exec_cmd("if command -v fcitx5 >/dev/null 2>&1; then fcitx5 -d; fi")
    -- Refresh the user systemd environment before starting clipboard watchers.
    hl.exec_cmd("if command -v cliphist >/dev/null 2>&1; then systemctl --user import-environment WAYLAND_DISPLAY XDG_RUNTIME_DIR; systemctl --user restart cliphist-text.service cliphist-image.service; fi")
end)
