### Essentials

# vi mode
bindkey -v
export KEYTIMEOUT=1

export EDITOR="nvim"
export TERMINAL="kitty"
export READER="mupdf -gl"
export VISUAL="nvim"
export VIDEO="mpv"
export IMAGE="/Applications/qView.app/Contents/MacOS/qView"
export OPENER="open"
export NVIMRC="~/.config/nvim/init.lua"
export PATH="$HOME/.emacs.d/bin:$PATH"
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8
PATH=$PATH:~/.local/bin
PATH=$PATH:~/scripts
# Enable colors and change prompt:
autoload -U colors && colors
# History in cache directory:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.cache/zsh/history
autoload -U compinit && compinit -u
zstyle ':completion:*' menu select
# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.
# colorful man pages
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;32m'
export FZF_DEFAULT_COMMAND="rg ~ --files --hidden -g '!/Library/'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
alias rg="rg -g '!/Library/'" 

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


### File managing aliases

alias down='cd ~/Downloads'
alias doc='cd ~/Documents'
alias dev="cd ~/dev/"
alias sd="cd ~/Documents/ && fd . $HOME/Documents"
alias ..='cd ..'
alias cd..="cd .."
alias mv="mv -i"
alias g='cd "$(ls -d */| fzy)"'
alias ls='lsd'
alias l='exa --long --grid'
alias ll='ls -lhtrF --color=auto'
alias lh='ls -lhtrdF .*'
alias tree='exa -T'
alias grep="grep --color=auto"
alias r='rm -rf "$(ls -d */ | fzf)"'
alias rf='rm -i "$(find . -maxdepth 1 -type f| fzf)"'
alias v='nvim'
alias nv='nvim'
alias vki="vim -c ':VimwikiIndex'"
alias vimwiki="vim -c ':VimwikiIndex'"
alias f="fzf"

### Suffix aliases
alias -s md=nvim
alias -s mp4=mpv
alias -s mkv=mpv

### Media aliases

alias ani='cd ~/anime'
alias trackma='trackma -a 1'
alias syncplay='/Applications/Syncplay.app/Contents/MacOS/Syncplay'
alias mpvq="mpv --no-video"

### yt-dlp aliases
# don't forget to download ffmpeg :/

alias ytdl="yt-dlp -f 'bestvideo+bestaudio' --embed-thumbnail --embed-subs --embed-metadata"
alias ytdl-mp3="yt-dlp --extract-audio --audio-format mp3 --audio-quality 0"
alias ytdlist="yt-dlp -f 'bv*[height=1080]+ba'"


### Other aliases

alias nf='neofetch --kitty ~/.config/neofetch/neofetch.jpeg --size 30%'
alias nft='neofetch --iterm2 ~/.config/neofetch/neofetch.jpeg'
alias python='python3'
alias pip='pip3'
alias u='exec zsh'
alias myip="curl ipinfo.io/ip"
alias ytm="ytfzf -m"
alias cf="change_folder"
alias ofm="open_pdf_fzf_mupdf"
alias of="open_with_fzf"
alias nvf="open_with_nvim"
alias mpf="open_with_mpv"
alias msf="open_with_mpv_silent"
alias imf="open_image_fzf"
alias nb="newsboat"


### Life one ez mode
function chst {
    [ -z $1 ] && echo "no args provided!" || (curl -s cheat.sh/$1 | bat --style=plain)
}

mkcd() {
    if [ "$#" -lt 1 ]; then
        echo "no arguments provided!"
        return
    elif [ "$#" -gt 1 ]; then
        echo "too many arguments! ignoring extra.."
    fi
    test -d "$1" || mkdir "$1" && cd "$1"
}

change_folder() {
    # if no argument is provided, search from ~ else use argument
    [[ -z $1 ]] && DIR=~ || DIR=$1
    # choose file using rg and fzf
    CHOSEN=$(fd . -H -t d $DIR | fzf --preview="exa -s type --icons {}" --bind="ctrl-space:toggle-preview" --preview-window=,30:hidden)

    # quit if no path is selected else cd into the path
    if [[ -z $CHOSEN ]]; then
        echo $CHOSEN
        return 1
    else
        cd "$CHOSEN"
    fi

    # show ls output if dir has less than 61 files
    [[ $(ls | wc -l) -le 60 ]] && (pwd; ls)
    return 0
}

open_pdf_fzf_mupdf() {
    PDF_PATH=$(rg --files -t pdf| fzf )
    [[ -z $PDF_PATH ]] || (mupdf-gl "$PDF_PATH" &> /dev/null)
}

open_with_mpv() {
  VIDEO_PATH=$(rg --files -g '!anime/' -g '!for_editing/' -g '*.{mp4,mkv,webm,m4v}' | fzf )
    [[ -z $VIDEO_PATH ]] || (mpv "$VIDEO_PATH")
}

open_with_mpv_silent() {
    VIDEO_PATH=$(rg --files -g '*.{mp3,flac,m4a}'| fzf )
    [[ -z $VIDEO_PATH ]] || (mpv --no-video "$VIDEO_PATH")
}

open_image_fzf() {
  IMAGE_PATH=$(rg --files -g '*.{jpg,png,jpeg,webp,gif}' | fzf )
    [[ -z $IMAGE_PATH ]] || (open "$IMAGE_PATH")
}

open_with_fzf() {
    FILE=$(rg --files | fzf )
    [[ -z "$FILE" ]] || (open "$FILE" &> /dev/null)
}

open_with_nvim() {
  nvim $(fzf)
}



### Git

gc() { git clone https://github.com"$@"; }
gci() { git clone https://github.com/iamchokerman"$@"; }

# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fco - checkout git branch/tag
fco() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi -n 2 \
        --ansi) || return
  git checkout $(awk '{print $2}' <<<"$target" )
}

# fco_preview - checkout git branch/tag, with a preview showing the commits between the tag/branch and HEAD
fco_preview() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi -n 2 \
        --ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'") || return
  git checkout $(awk '{print $2}' <<<"$target" )
}

# fcoc - checkout git commit
fcoc() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fcs - get git commit sha
# example usage: git rebase -i `fcs`
fcs() {
  local commits commit
  commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
  echo -n $(echo "$commit" | sed "s/ .*//")
}


### Media

w () {
  while :; do
    tmp="$(fzf)" 
    if [ -z "$tmp" ]; then
      break
    fi
    mpv "$tmp" 
    rm -vi "$tmp"
  done
  }

te () {
    dir="/Volumes/EXTERNAL/chokerman/media/tv shows"
    tmp3="$(ls "$dir" | fzf)"
    tmp="$tmp3/$(ls "$dir/$tmp3" | fzf)"
    if [ -z "$tmp" ]; then
      break
    fi
    while :; do
              tmp2="$(ls "$dir/"$tmp"/" | fzf)"
        if [ -z "$tmp2" ]; then
          break
        fi
        mpv "$dir/"$tmp"/$tmp2"
        rm -vi "$dir/"$tmp"/$tmp2"
    done
}

me () {
    dir="/Volumes/EXTERNAL/chokerman/media/movies"
    tmp="$(ls "$dir" | fzf)"
    if [ -z "$tmp" ]; then
      break
    fi
    while :; do
              tmp2="$(ls "$dir/"$tmp"/" | fzf)"
        if [ -z "$tmp2" ]; then
          break
        fi
        mpv "$dir/"$tmp"/$tmp2"
        rm -vi "$dir/"$tmp"/$tmp2"
    done
}

ae () {
    dir="/Volumes/EXTERNAL/chokerman/media/anime"
    tmp="$(ls "$dir" | fzf)"
    if [ -z "$tmp" ]; then
      break
    fi
    while :; do
              tmp2="$(ls "$dir/"$tmp"/" | fzf)"
        if [ -z "$tmp2" ]; then
          break
        fi
        mpv "$dir/"$tmp"/$tmp2"
        rm -vi "$dir/"$tmp"/$tmp2"
    done
}


### Fzf funtions

alias p="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"

# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

### Other

emoji() {
  emojis=$(curl -sSL 'https://git.io/JXXO7')
  selected_emoji=$(echo $emojis | fzf)
  echo "$selected_emoji" | awk '{print $1}' | pbcopy
} 
