#!/bin/sh
yt-dlp -f "bv*+ba" --embed-thumbnail --embed-subs --merge-output-format mp4 -P "$(fd . "/Users/ivan" --type d -E Library -E go/|fzf)" "$(pbpaste)"
osascript -e 'quit app "iTerm"'
