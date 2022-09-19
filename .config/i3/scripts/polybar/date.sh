#!/usr/bin/env bash

format="+ %a %b %d, %R"
posx=-100
posy=30
cmd="yad --calendar --undecorated --fixed --close-on-unfocus --no-buttons --title='yad-calendar' --borders=0"

while getopts ":px:y:f:" opt; do
    case $opt in
        x) posx="${OPTARG}";;
        y) posy="${OPTARG}";;
        w) width="${OPTARG}";;
        h) height="${OPTARG}";;
        f) format="${OPTARG}";;
        p) popup=1;;
    esac
done

if [[ -z $popup ]]; then
    date "$format"
    exit 0
fi

[[ -n $width ]] && cmd+=" --width=$width"
[[ -n $height ]] && cmd+=" --height=$height"
cmd+=" --posx=$posx"
cmd+=" --posy=$posy"

eval "$cmd"
