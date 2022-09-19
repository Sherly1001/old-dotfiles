#!/usr/bin/env bash

[[ ! -f /usr/bin/inotifywait ]] && exit 1

card=intel_backlight
brightness="/sys/class/backlight/$card/actual_brightness"
max_brightness="/sys/class/backlight/$card/max_brightness"

icons=(🌑 🌒 🌓 🌔 🌕)

show_brightness() {
    cur=`cat "$brightness"`
    max=`cat "$max_brightness"`
    val=`echo "print(f'{$cur * 100/$max:.0f}')" | python`

    len=${#icons[@]}
    idx=$(((val - 1) * len / 100))
    icon=${icons[$idx]}

    echo "$icon $val%"
}

show_brightness
while inotifywait -qq "$brightness"; do
    show_brightness
done
