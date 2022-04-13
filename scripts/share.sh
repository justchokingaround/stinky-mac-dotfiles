#!/bin/sh

FILE=$(fd -t f -E Library -E go|fzf)
LINK=$(curl -# "https://oshi.at" -F "f=@$FILE"|awk '/DL/ {print $2}')
printf "$LINK"|pbcopy
printf "$LINK"
osascript -e 'quit app "Terminal"'
