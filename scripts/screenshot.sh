#!/bin/sh
screencapture -c -i 
location=$(find ~/Pictures -maxdepth 1 -mindepth 1 -type d|fzf)
name=$(find $location -maxdepth 4 -type f|fzf --print-query|head -n 1)
pngpaste "$location/$name.jpg"
osascript -e 'quit app "Terminal"'
