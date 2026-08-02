#!/usr/bin/env bash
# Network speed monitor for Waybar
# Displays real-time download/upload speeds with auto unit conversion

CACHE_FILE="/tmp/waybar-network-cache-${USER}"


get_interface() {

    if [ -n "$1" ]; then
        echo "$1"
        return
    fi

    # 优先使用默认路由接口
    local iface
    iface=$(ip route | awk '/default/ {print $5; exit}')

    if [ -n "$iface" ]; then
        echo "$iface"
        return
    fi


    # fallback wifi
    if command -v iw >/dev/null 2>&1; then
        iface=$(iw dev 2>/dev/null | awk '/Interface/{print $2}' | head -n1)

        if [ -n "$iface" ]; then
            echo "$iface"
            return
        fi
    fi


    # fallback 普通网卡
    ip -o link show up |
        awk -F': ' '{print $2}' |
        grep -Ev 'lo|vir|br|docker|veth|tun' |
        head -n1
}


format_speed() {

    local speed=$1

    if [ "$speed" -ge 1048576 ]; then
        echo "$(awk "BEGIN {printf \"%.1f\", $speed/1048576}")MB/s"

    elif [ "$speed" -ge 1024 ]; then
        echo "$(awk "BEGIN {printf \"%.1f\", $speed/1024}")KB/s"

    else
        echo "${speed}B/s"
    fi
}


get_stats() {

    local iface=$1

    awk -v iface="$iface:" '
    $1 == iface {
        print $2,$10
    }' /proc/net/dev
}



IFACE=$(get_interface "${WAYBAR_NETWORK_INTERFACE:-}")


if [ -z "$IFACE" ]; then
    echo '{"text": "󰖩 No Interface", "class": "disconnected"}'
    exit 0
fi



read -r rx_bytes tx_bytes <<< "$(get_stats "$IFACE")"



if ! [[ "$rx_bytes" =~ ^[0-9]+$ ]] ||
   ! [[ "$tx_bytes" =~ ^[0-9]+$ ]]; then

    echo '{"text": "󰖩 Error", "class": "disconnected"}'
    exit 0
fi



now=$(date +%s)



# 第一次运行
if [ ! -f "$CACHE_FILE" ]; then

    echo "$IFACE $rx_bytes $tx_bytes $now" > "$CACHE_FILE"

    echo '{"text": "󰖩 Measuring...", "class": "connecting"}'

    exit 0
fi



read -r prev_iface prev_rx prev_tx prev_time < "$CACHE_FILE"



if [ "$prev_iface" != "$IFACE" ]; then

    echo "$IFACE $rx_bytes $tx_bytes $now" > "$CACHE_FILE"

    echo '{"text": "󰖩 Measuring...", "class": "connecting"}'

    exit 0
fi



time_diff=$((now-prev_time))


if [ "$time_diff" -le 0 ]; then
    time_diff=1
fi



rx_speed=$(( (rx_bytes-prev_rx)/time_diff ))
tx_speed=$(( (tx_bytes-prev_tx)/time_diff ))



[ "$rx_speed" -lt 0 ] && rx_speed=0
[ "$tx_speed" -lt 0 ] && tx_speed=0



echo "$IFACE $rx_bytes $tx_bytes $now" > "$CACHE_FILE"



rx_formatted=$(format_speed "$rx_speed")
tx_formatted=$(format_speed "$tx_speed")



if [ "$rx_speed" -eq 0 ] && [ "$tx_speed" -eq 0 ]; then

    class="idle"

elif [ "$rx_speed" -gt 1048576 ] || [ "$tx_speed" -gt 1048576 ]; then

    class="high"

elif [ "$rx_speed" -gt 102400 ] || [ "$tx_speed" -gt 102400 ]; then

    class="medium"

else

    class="low"

fi



printf '{"text": "%s ↓ %s ↑", "tooltip": "网卡: %s\\n下载: %s\\n上传: %s", "class": "%s"}\n' \
    "$rx_formatted" \
    "$tx_formatted" \
    "$IFACE" \
    "$rx_formatted" \
    "$tx_formatted" \
    "$class"