#!/bin/sh

FILE=$(fd -t f -E Library -E go|fzf)
LINK=$(curl -# "https://oshi.at" -F "f=@$FILE"|awk '/DL/ {print $2}')
printf "\`\`\`"mpv" \""$LINK"\"\`\`\`"|pbcopy
printf "\`\`\`"mpv" \""$LINK"\"\`\`\`"
osascript -e 'quit app "Terminal"'
