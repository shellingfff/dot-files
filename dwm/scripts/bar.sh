
get_backlight()
{
    #echo $(xbacklight | sed 's/\..*//g')
    max=$(brightnessctl m)
    cur=$(brightnessctl g)
    per=$(echo "scale=2; $cur / $max * 100" | bc)
    echo $(printf "%0.f" "$per")

}

get_date()
{
    echo "$(date '+%m %d %Y')"
}

get_time()
{
    #echo "$(date '+%H:%M:%S')"
    echo "$(date '+%H:%M')"
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
    #xsetroot -name  ";| $(get_time) | $(get_date) | $(get_day) | BRI $(get_backlight) | VOL $(get_volume) | MEM $(get_memory) | BAT $(get_battery) |"
    #
    #xsetroot -name  "| $(get_time) | $(get_date) | VOL $(get_volume) | BAT $(get_battery) |"

    # without date
    xsetroot -name  "| $(get_time) | VOL $(get_volume) | BAT $(get_battery) |"
    #
    #xsetroot -name  "top text; bottom text"
    sleep 1
done
