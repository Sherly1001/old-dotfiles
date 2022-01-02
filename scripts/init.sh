#!/usr/bin/env bash

links=(alacritty dunst picom.conf polybar rofi)

cd ..
for link in "${links[@]}"; do
    ln -sf "./i3/$link" .
done
