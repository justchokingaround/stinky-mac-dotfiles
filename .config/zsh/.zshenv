export EDITOR="nvim"
export TERMINAL="kitty"
export READER="mupdf -gl"
export VISUAL="nvim"
export VIDEO="mpv"
export IMAGE="/Applications/qView.app/Contents/MacOS/qView"
export OPENER="open"
export BROWSER="/Applications/Firefox Nightly.app/Contents/MacOS/firefox"
export WM="yabai"
export PAGER="bat"

export NNN_BMS='D:~/Downloads;d:~/dev'
export NNN_USE_EDITOR=1
export NNN_COLORS='6125'
export NNN_PLUG='o:fzopen;j:autojump;c:cdpath;g:getplugs;i:imgview;p:preview-tui;u:upload;w:wallpaper'

LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8
export PATH="$HOME/.emacs.d/bin:$PATH"
export GOPATH=$HOME/go-workspace # don't forget to change your path correctly!
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.spicetify
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$HOME/Library/Python/3.8/bin/
source $HOME/.cargo/env 
export BAT_CONFIG_PATH="$HOME/.config/bat"
PATH=$PATH:~/.local/bin
PATH=$PATH:/usr/bin
PATH=$PATH:~/dotfiles/scripts
PATH=$PATH:~/dotfiles/scripts/presence
PATH=$PATH:~/.local/share
PATH=$PATH:$HOME/.spicetify

# colorful man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
