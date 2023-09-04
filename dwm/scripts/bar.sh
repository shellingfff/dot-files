
get_backlight()
{
    echo $(xbacklight | sed 's/\..*//g')
}

get_date()
{
    echo "$(date '+%m %d %Y')"
}

get_time()
{
    echo "$(date '+%H:%M:%S')"
}

get_day()
{
    echo "$(date '+%a')"
}

get_volume()
{
    echo "$(pactl get-sink-volume @DEFAULT_SINK@ | tail -n 2 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,' | head -n 1)"
}

get_memory()
{
    echo $(free | awk '/Mem/{printf("%d"), $3/$2*100}')
}

get_battery()
{
    echo $(cat /sys/class/power_supply/BAT1/capacity)
}

while true; do
    xsetroot -name  "| $(get_time) | $(get_date) | $(get_day) | BRI $(get_backlight) | VOL $(get_volume) | MEM $(get_memory) | BAT $(get_battery) |"
    sleep 1
done
