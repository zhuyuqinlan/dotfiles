#!/usr/bin/env bash
# Power profiles toggle script for Waybar
# Cycles through power profiles: performance -> balanced -> power-saver -> performance

if ! command -v powerprofilesctl &>/dev/null; then
    notify-send "Power Profiles" "powerprofilesctl not found" 2>/dev/null
    exit 1
fi

current=$(powerprofilesctl get 2>/dev/null)

case "$current" in
    performance)
        next="balanced"
        ;;
    balanced)
        next="power-saver"
        ;;
    power-saver|*)
        next="performance"
        ;;
esac

powerprofilesctl set "$next" 2>/dev/null
notify-send "Power Profile" "Switched to $next" 2>/dev/null
