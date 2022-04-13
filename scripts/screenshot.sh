#!/bin/sh
screencapture -i "/tmp/tmp_screencapture.jpg"
location=$(find ~/Pictures -maxdepth 1 -mindepth 1 -type d|fzf)
name=$(find $location -maxdepth 4 -type f|fzf --print-query|head -n 1)
mv "/tmp/tmp_screencapture.jpg" "$location/$name.jpg"
rm "/tmp/tmp_screencapture.jpg" > /dev/null 2>&1
osascript -e 'quit app "Terminal"'
