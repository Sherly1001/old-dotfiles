#!/usr/bin/env bash

[[ -f /tmp/bg_pid ]] && kill `cat /tmp/bg_pid`

pic_dir="/cmn/anime_pictures"
if [[ -n $1 ]]; then
    pic_dir="$1"
fi

if [[ ! -d $pic_dir ]]; then
    feh --no-fehbg --bg-fill ~/.config/i3/imgs/sayu_bg.png
    exit 0
fi

echo $$ > /tmp/bg_pid
while true; do
    for img in `eval find "$pic_dir" | shuf`; do
        feh --no-fehbg --bg-fill $img
        echo $img >> /tmp/cur_bg
        sleep 60
    done
done
