### File managing aliases

alias down='cd ~/Downloads'
alias doc='cd ~/Documents'
alias ..='cd ..'
alias ../..='cd ../..'
alias ../../..='cd ../../..'
alias ../../../..='cd ../../../..'
alias ../../../../..='cd ../../../../..'
alias cd..="cd .."
alias mv="mv -i"
alias ls='exa'
alias ll='exa -Fal'
alias l='exa --long --grid'
alias lh="exa -a"
alias tree='exa -T'
alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"
alias rd='rm -rI "$(exa -D| fzf --height=20% --preview="exa -l {}")"'
alias cx='chmod +x "$(find . -maxdepth 1 -type f| fzf)"'
alias nv='nvim'
alias n='nnn -a'
alias v='nvim'
alias lv='lvim'
alias f="fzf"
alias ra="ranger"
alias nvs="cd ~/dotfiles/.config/zsh && nvim ~/dotfiles/.config/zsh/.zshrc"
alias nvc="cd ~/dotfiles/.config/nvim/lua/user && nvim ~/dotfiles/.config/nvim/lua/user/options.lua"
alias j=z
alias jj="cd -"
alias bi="brew install"
alias bu="brew uninstall"

### Suffix aliases
alias -s md=nvim
alias -s mp4=mpv
alias -s mp3=mpv
alias -s mkv=mpv
alias -s jpg=open
alias -s pdf=mupdf-gl

### Media aliases

alias trackma='trackma -a 1'
alias syncplay='/Applications/Syncplay.app/Contents/MacOS/Syncplay'
alias flameshot='/Applications/flameshot.app/Contents/MacOS/flameshot'
alias mpvq="mpv --no-video"
alias watchgoodedits='cd "$(fd . "$HOME/good_edits" --max-depth 1 --type d|fzf --cycle)" && mpv *'

### yt-dlp aliases
# don't forget to download ffmpeg :/

alias ytdl="yt-dlp -f 'bv*+ba' --embed-thumbnail --embed-subs --merge-output-format mp4"
alias ytdl-mp3="yt-dlp --embed-metadata --extract-audio --audio-format mp3 --audio-quality 0 --embed-thumbnail"
alias ytdlist="yt-dlp -f 'bv*[height=1080]+ba'"
alias gedl='yt-dlp -f "bv*+ba" --embed-thumbnail --embed-subs --merge-output-format mp4 -P "$(find ~/good_edits -maxdepth 1 -type d|fzf)" "$(pbpaste)"'
alias fytdl='yt-dlp -f "bv*+ba" --embed-thumbnail --embed-subs --merge-output-format mp4 -P "$(fd . "/Users/justchokingaround" --type d -E Library -E go/|fzf)" "$(pbpaste)"'
alias fytdl-mp3='yt-dlp --embed-metadata --extract-audio --audio-format mp3 --audio-quality 0 --embed-thumbnail -P "$(fd . "/Users/justchokingaround" --type d -E Library -E go/|fzf)" "$(pbpaste)"'
alias fytdlist='yt-dlp -f "bv*[height=1080]+ba" -P "$(fd . "/Users/justchokingaround" --type d -E Library -E go/|fzf)" "$(pbpaste)"'

### Other aliases

alias share='printf $(curl -# "https://oshi.at" -F "f=@$(fd -t f|fzf)"|sed -nE "s_DL: (.*)_\1_p")|pbcopy'
alias weather="curl -s wttr.in/Heilbronn"
alias pf='pfetch'
alias nft='neofetch --kitty ~/.config/neofetch/neofetch.jpeg --size 30%'
alias nf='neofetch'
alias py='python3'
alias pip='pip3'
alias u='exec zsh'
alias myip="curl ipinfo.io/ip"
alias ytm="ytfzf -m"
alias nvf="open_with_nvim"
alias hxf="open_with_helix"
alias nvj="open_with_nvim_java"
alias lvf="open_with_lvim"
alias lvj="open_with_lvim_java"
alias mpf="open_with_mpv"
alias mpfq="open_with_mpv_quiet"
alias msf="open_with_mpv_silent"
alias ipf="open_with_iina"
alias imf="open_image_fzf"
alias mpe="open_with_mpv_external"
alias nb="newsboat"
alias awho="animewho"
alias epy="python3 ~/dev/epy/epy.py"
alias -g L='| less'
alias -g G='| grep -i'
alias -g CUT='| cut'
alias -g C='| pbcopy'
alias -g P='| '
alias -g H="| htmlq 'body' | bat --language html"
alias -g A="| awkg -b 'from html import unescape' 'print(unescape(R0))' "
alias -g PUP="| pup 'text{}'"
alias -g S="| sed"
alias -g F="| fzf"
alias -g X="| xargs -r"
alias -g B="| bat"
alias -g J="| jq"
