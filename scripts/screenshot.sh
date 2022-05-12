#!/bin/sh
screencapture -c -i 
location=$((fd . '/Users/ivan/Pictures' '/Users/ivan/Downloads' --type d -E nsfw && printf "/Users/ivan/Pictures\n/Users/ivan/Downloads")|fzf)
name=$(find $location -maxdepth 4 -type f|fzf --print-query|head -n 1)
pngpaste "$location/$name.jpg"
osascript -e 'quit app "iTerm"'
