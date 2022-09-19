#!/usr/bin/env bash

while getopts ":sn" opt; do
    case $opt in
        s) sound_enable=1;;
        n) notify_enable=1;;
        *) OPTIND=$((OPTIND-1)); break;;
    esac
done
shift $((OPTIND-1))

if [[ -n $1 ]]; then
    light "$@"
fi

brightness=`printf "%0.f%%" $(light)`
echo $brightness

if [[ -n $notify_enable ]]; then
    pid=$$
    [[ -f /tmp/light_pid ]] && pid=`cat /tmp/light_pid` || echo $$ > /tmp/light_pid
    dunstify -r $pid brightness "$brightness"
fi

if [[ -n $sound_enable ]]; then
    play /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga > /dev/null 2>&1
fi
