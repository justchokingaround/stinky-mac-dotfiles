#!/bin/bash

space_number=$(yabai -m query --spaces --space | jq -r .index)
yabai_mode=$(yabai -m query --spaces --space | jq -r .type)

case "$yabai_mode" in
    bsp)
    sketchybar -m --set yabai_mode label="􀏝" \
    label.color="0xffff5f87"                                               
    ;;
    stack)
    sketchybar -m --set yabai_mode label="􀏭" \
    label.color="0xffff5f87"                                               
    ;;
    float)
    sketchybar -m --set yabai_mode label="􀢌" \
    label.color="0xffff5f87"                                               
    ;;
esac
