# custom aliases
alias rm='shred -uzvn3' 
alias ff='find . -type f -iname'
alias yt='ytfzf -t'
alias weather='curl wttr.in/heilbronn'
alias sudo="sudo "
alias py='python3'
alias matrix='tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;32" grep --color "[^ ]"'
alias dup='find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate'
alias hollywood='echo "You can simulate on-screen typing just like in the movies" | pv -qL 10'
alias functions='shopt -s extdebug;declare -F | grep -v "declare -f _" | declare -F $(awk "{print $3}") | column -t;shopt -u extdebug'
alias sx="sxiv -ft *"
alias emptytrash="sudo rm -frv /Volumes/*/.Trashes && \
                  sudo rm -frv ~/.Trash &&
                  sudo rm -frv /private/var/log/asl/*.asl"
alias smi='sudo make clean install'
alias text='cd /home/ivan/.local/bin ; ./marktext-x86_64.AppImage'
alias ls='lsd'
alias l='ls -ahl --color=auto'
alias ll='ls -hl --color=auto'

alias cat='lolcat'
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BA T1'
alias bat='acpi'
alias refreshkeys='xbindkeys --poll-rc'
alias list='nnn -de'
alias define='sdcv'
alias def='sdcv'
alias ..='cd ..'
alias u='source ~/.bashrc'
alias aw='ani-cli -k'
alias awh='ani-cli -k -H'
alias awu='ani-cli -U'
alias awt='./ani-cli'
alias down='cd ~/Downloads'
alias doc='cd ~/Documents'
alias oi='oi -l en-US'
alias share='curl -F"file=@$(fd| dmenu -l 15)" 0x0.st | xclip -sel c'
alias lt='du -sh * | sort -h'
alias cp='cp -vR'
alias mkdir='mkdir -vp'
alias mv='mv -v'
alias rm='rm -vR'
alias pacman='sudo pacman'
alias copy="xclip -selection c"
alias paste="xclip -selection c -o"
alias co='xclip -selection c -i -f'
alias p='xclip -selection c -o'
alias x='chmod +x'
alias c2f='_CELtoFER() { calc "$1" \* 1.8 \+ 32 ;}; _CELtoFER'
alias xclip="xclip -selection clipboard"
alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"
alias redyt="rm -rf /tmp/redyt* ; cd /home/ivan/.local/bin/redyt ; ./redyt"

# Git stuff
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gs='git status'
alias gd='git diff'
alias gf='git fetch'
alias gm='git merge'
alias gr='git rebase'
alias gp='git push'
alias gu='git unstage'
alias gco='git checkout'
alias gb='git branch'


# editing configs
alias cfb="nvim ~/.bashrc && source ~/.bashrc"
alias cfi="nvim ~/.config/i3/config"
alias cfii="nvim ~/.config/i3blocks/config"
alias cff="nvim ~/.config/fontconfig/fonts.conf"
alias cfv="nvim ~/.vimrc"
alias cfnv="nvim ~/.config/nvim/init.vim"
alias cfp="nvim ~/.config/picom.conf"

alias clc="calcurse"
alias scim="sc-im"
alias tdwn="transmission-daemon" # or mod+t to toggle it
alias tdir="cd ~/myfiles/junk/testspace"
alias jupy="coa pyimg;jupyter notebook"
alias npc="ncmpcpp"
alias playalert="mpv --really-quiet ~/.local/share/sounds/complete.ogg"
alias ytdl="yt-dlp -f 'bestvideo+bestaudio' -o '%(title)s.%(ext)s'"
alias ytdl-mp3="yt-dlp --extract-audio --audio-format mp3 --audio-quality 0 -o '%(title)s.%(ext)s'"
alias ytdlist="yt-dlp -f 'bestvideo+bestaudio' -o '%(playlist_index)s-%(title)s.%(ext)s'"
alias ctodo="nvim ~/todo.md"
alias vki="nvim -c ':VimwikiIndex'"
alias vimwiki="vim -c ':VimwikiIndex'"

# for setting default scale as 4 in bc
#alias bc="BC_ENV_ARGS=<(echo "scale=4") \bc"

# xclip is hard!
alias xclipp="xclip -i -selection primary"
alias xclipc="xclip -i -selection clip"

# code editor aliases
alias v="nvim"
alias vv="nvim"
alias nv="nvim"
alias nf="neofetch | lolcat"
alias pf="pfetch"

# a quick hack to store quicknotes, now replaced by vimwiki
alias qnl="vim ~/myfiles/junk/qnotes"

# life improvements
alias update="sudo pacman -Syyu"
alias myip="curl ipinfo.io/ip"
alias cwall="feh --bg-fill --randomize /home/ivan/Pictures/wallpapers*;clear"
alias lm="ls -tlh"
alias passgh="pass github-pat | xclip -i -r -sel clipboard"
alias coa="conda activate"
alias mpvq="mpv --no-video"

# quiet and interacture youtube audio player
alias ytp="youtube-viewer -n --no-video-info --player=mpvt"

# devour aliases
alias manga="devour feh --scale-down"
alias mpvd="devour mpv"
alias zathurd="devour zathura"

# aliases for fzf
export FZF_DEFAULT_COMMAND="rg --files --hidden"
alias cpcmd="history | cut -c 8- | uniq | fzf | xclip -i -r -sel clipboard"
alias c='file=$(rg --files --hidden | fzf | sed "s~/[^/]*$~/~");[[ "$file" == "" ]]|| cd "$file"'
alias cf='cd $(fd . -H -t d ~ | fzf)'
alias fzfo='devour xdg-open "$(rg --files | fzf)" &> /dev/null'
alias op='echo "$(rg --files -t pdf | fzf)" | xargs -r -0 -I{} devour zathura "{}"'
alias oko='devour okular "$(rg --files -t pdf | fzf)" &> /dev/null'
alias rgf='$(rg --files | fzf)'

function cl() {
    DIR="$*";
        # if no DIR given, go home
        if [ $# -lt 1 ]; then
                DIR=$HOME;
    fi;
    builtin cd "${DIR}" && \
    # use your preferred ls command
        ls -F --color=auto
}

function jump {
    cd -P $MARKPATH/$1 2>/dev/null || echo "No such mark: $1"
}
function mark {
    mkdir -p $MARKPATH; ln -s $(pwd) $MARKPATH/$1
}
function unmark {
    rm -i $MARKPATH/$1
}
function marks {
    ls -l $MARKPATH | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}
_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $MARKPATH -type l -printf "%f\n")
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

complete -F _completemarks jump unmark

# make a backup of a file
# https://github.com/grml/grml-etc-core/blob/master/etc/zsh/zshrc

bk() {
    cp -a "$1" "${1}_$(date --iso-8601=seconds)"
}

youtube()
{
    local s="$_"
    local query=

    case "$1" in
        '')   ;;
        that) query="search_query=${s//[[:space:]]/+}" ;;
        *)    s="$*"; query="search_query=${s//[[:space:]]/+}" ;;
    esac

    $BROWSER "http://www.youtube.com/results?${query}"
}

google()
{
    local s="$_"
    local query=

    case "$1" in
        '')   ;;
        that) query="search?q=${s//[[:space:]]/+}" ;;
        *)    s="$*"; query="search?q=${s//[[:space:]]/+}" ;;
    esac

    $BROWSER "http://www.google.com/${query}"
}

googlei()
{
    local s="$_"
    local query=

    case "$1" in
        '')   ;;
        that) query="search?q=${s//[[:space:]]/+}&tbm=isch&tbs=isz:l&hl=en" ;;
        *)    s="$*"; query="search?q=${s//[[:space:]]/+}&tbm=isch&tbs=isz:l&hl=en" ;;
    esac

    $BROWSER "http://www.google.com/${query}"
}

yandex()
{
    local s="$_"
    local query=

    case "$1" in
        '')   ;;
        that) query="search?text=${s//[[:space:]]/+}&isize=large" ;;
        *)    s="$*"; query="search?text=${s//[[:space:]]/+}&isize=large" ;;
    esac

    $BROWSER "http://yandex.ru/${query}"
}

yandexi()
{
    local s="$_"
    local query=

    case "$1" in
        '')   ;;
        that) query="search?text=${s//[[:space:]]/+}&isize=large" ;;
        *)    s="$*"; query="search?text=${s//[[:space:]]/+}&isize=large" ;;
    esac

    $BROWSER "http://yandex.ru/images/${query}"
}

#Converting audio and video files
function 2ogg() { eyeD3 --remove-all-images "$1"; fname="${1%.*}"; sox "$1" "$fname.ogg" && rm "$1"; }
function 2wav() { fname="${1%.*}"; ffmpeg -threads 0 -i "$1" "$fname.wav" && rm "$1"; }
function 2aif() { fname="${1%.*}"; ffmpeg -threads 0 -i "$1" "$fname.aif" && rm "$1"; }
function 2mp3() { fname="${1%.*}"; ffmpeg -threads 0 -i "$1" "$fname.mp3" && rm "$1"; }
function 2mov() { fname="${1%.*}"; ffmpeg -threads 0 -i "$1" "$fname.mov" && rm "$1"; }
function 2mp4() { fname="${1%.*}"; ffmpeg -threads 0 -i "$1" "$fname.mp4" && rm "$1"; }
function 2avi() { fname="${1%.*}"; ffmpeg -threads 0 -i "$1" "$fname.avi" && rm "$1"; }
function 2webm() { fname="${1%.*}"; ffmpeg -threads 0 -i "$1" -c:v libvpx "$fname.webm" && rm "$1"; }
function 2h265() { fname="${1%.*}"; ffmpeg -threads 0 -i "$1" -c:v libx265 "$fname'_converted'.mp4" && rm "$1"; }
function 2flv() { fname="${1%.*}"; ffmpeg -threads 0 -i "$1" "$fname.flv" && rm "$1"; }
function 2mpg() { fname="${1%.*}"; ffmpeg -threads 0 -i "$1" "$fname.mpg" && rm "$1"; }

#Converting documents and images
function 2txt() { soffice --headless txt "$1"; }
function 2pdf() {
    if [ ${1: -4} == ".html" ]
    then
        fname="${1%.*}"
        soffice --headless --convert-to odt "$1"
        soffice --headless pdf "$fname.html"
    else
        soffice --headless pdf "$1"
    fi
}
function 2doc() { soffice --headless doc "$1"; }
function 2odt() { soffice --headless odt "$1"; }
function 2jpeg() { fname="${1%.*}"; convert "$1" "$fname.jpg" && rm "$1"; }
function 2jpg() { fname="${1%.*}"; convert "$1" "$fname.jpg" && rm "$1"; }
function 2png() { fname="${1%.*}"; convert "$1" "$fname.png" && rm "$1"; }
function 2bmp() { fname="${1%.*}"; convert "$1" "$fname.bmp" && rm "$1"; }
function 2tiff() { fname="${1%.*}"; convert "$1" "$fname.tiff" && rm "$1"; }
function 2gif() {
    fname="${1%.*}"
    if [ ! -d "/tmp/gif" ]; then mkdir "/tmp/gif"; fi
    if [ ${1: -4} == ".mp4" ] || [ ${1: -4} == ".mov" ] || [ ${1: -4} == ".avi" ] || [ ${1: -4} == ".flv" ] || [ ${1: -4} == ".mpg" ] || [ ${1: -4} == ".webm" ]
    then
        ffmpeg -i "$1" -r 10 -vf 'scale=trunc(oh*a/2)*2:480' /tmp/gif/out%04d.png
        convert -delay 1x10 "/tmp/gif/*.png" -fuzz 2% +dither -coalesce -layers OptimizeTransparency +map "$fname.gif"
    else
        convert "$1" "$fname.gif"
        rm "$1"
    fi
    rm -r "/tmp/gif"
}
mkcd() { mkdir "$1" && cd "$1"; }
function extract()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}
