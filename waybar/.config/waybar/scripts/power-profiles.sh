#!/usr/bin/env bash
# Power profiles status script for Waybar
# Reads current power profile via powerprofilesctl and outputs JSON for Waybar

if ! command -v powerprofilesctl &>/dev/null; then
    printf '{"text": "󰚲 N/A", "tooltip": "powerprofilesctl not found", "class": "error"}\n'
    exit 0
fi

current=$(powerprofilesctl get 2>/dev/null)

case "$current" in
    performance)
        icon=""
        label="性能模式"
        css_class="performance"
        ;;
    balanced)
        icon=""
        label="均衡模式"
        css_class="balanced"
        ;;
    power-saver)
        icon=""
        label="省电模式"
        css_class="power-saver"
        ;;
    *)
        icon="󰚲"
        label="Unknown"
        css_class="error"
        ;;
esac

tooltip="当前状态: $label"
available="性能模式, 均衡模式, 节能模式"

if [ -n "$available" ]; then
    tooltip="$tooltip\n选项: $available"
fi
tooltip="$tooltip\n点击切换 "

printf '{"text": "%s   %s", "tooltip": "%s", "class": "%s"}\n' \
    "$icon" "$label" "$tooltip" "$css_class"
