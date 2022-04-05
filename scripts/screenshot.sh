#!/bin/sh
location=$(find ~/Pictures -maxdepth 1 -mindepth 1 -type d|fzf)
name=$(find $location -maxdepth 4 -type f|fzf --print-query|head -n 1)
screencapture -i "$location/$name.jpg"
