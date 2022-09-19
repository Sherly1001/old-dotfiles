#!/usr/bin/env bash

icons=(🔈  🔉  🔊 )
icon_muted=🔇

headphones=(   )

color_enable="%{u`polybar -q -d green colors`}"
muted_color_enable="%{u`polybar -q -d red colors`}"

show_volume() {
    outp=(`amixer -D pulse sget Master |
        sed -n 's/^.*\[\(.*\)%\] \[\(on\|off\)\]/\1 \2/p' |
        head -1`)

    if [[ ${outp[1]} = off ]]; then
        show="$icon_muted ${outp[0]}%"
        [[ -n $muted_color_enable ]] && show="$muted_color_enable$show"
        echo "$show"
        return 0
    fi

    headphone_on=`amixer -D pulse -c 0 sget Headphone |
        sed -n 's/^.*\[\(on\|off\)\]/\1/p' |
        head -1`
    if [[ $headphone_on = on ]]; then
        icon_shows=("${headphones[@]}")
    else
        icon_shows=("${icons[@]}")
    fi

    val=${outp[0]}
    len=${#icon_shows[@]}
    idx=$(((val - 1) * len / 100))
    icon=${icon_shows[$idx]}

    show="$icon $val%"
    [[ -n $color_enable ]] && show="$color_enable$show"
    echo "$show"
}

show_volume
pactl subscribe |
while read event; do
    [[ ! $event =~ "'change' on sink" ]] && continue
    show_volume
done
