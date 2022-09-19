#!/usr/bin/env sh

killall polybar

for monitor in `xrandr | sed -n 's/ connected.*//p'`; do
    MONITOR=$monitor polybar -r main&
done
