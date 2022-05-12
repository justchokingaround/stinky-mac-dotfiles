#!/bin/sh

screencapture -c -i
NUMBER=$(( $(ls ~/Pictures/cote/ | wc -l) + 1 ))
pngpaste /Users/ivan/Pictures/cote/cote_$NUMBER.png
osascript -e 'quit app "iTerm"'
