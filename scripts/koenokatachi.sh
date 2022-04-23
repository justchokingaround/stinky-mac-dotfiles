#!/bin/sh

screencapture -c -i
NUMBER=$(( $(ls ~/Pictures/koe_no_katachi_emojis/ | wc -l) + 1 ))
pngpaste /Users/ivan/Pictures/koe_no_katachi_emojis/tmp_$NUMBER.png
osascript -e 'quit app "Terminal"'
