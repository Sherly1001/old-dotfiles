#!/usr/bin/env bash

while getopts ":sn" opt; do
    case $opt in
        s) sound_enable=1;;
        n) notify_enable=1;;
        *) OPTIND=$((OPTIND-1)); break;;
    esac
done
shift $((OPTIND-1))

[[ -z $1 ]] && cmd=sget || cmd=sset
vol=`amixer -D pulse $cmd Master "$@" | sed -n 's/.*\[\(.*%\)\].*/\1/p' | head -1`
echo $vol

if [[ -n $notify_enable ]]; then
    pid=$$
    [[ -f /tmp/vol_pid ]] && pid=`cat /tmp/vol_pid` || echo $$ > /tmp/vol_pid
    dunstify -r $pid volume $vol
fi

if [[ -n $sound_enable ]]; then
    play /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga > /dev/null 2>&1
fi
