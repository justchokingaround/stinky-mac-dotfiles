# pfetch
### Essentials

# vi mode
bindkey -v
export KEYTIMEOUT=1
# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

bindkey -s '^f' 'change_folder^M'
source "$HOME/dotfiles/.config/zsh/zsh-system-clipboard/zsh-system-clipboard.zsh"
source "$HOME/dotfiles/.config/zsh/forgit/forgit.plugin.zsh"
# used for tab completion with fzf 
source /Users/ivan/dotfiles/.config/zsh/fzf-tab/fzf-tab.plugin.zsh
source /Users/ivan/dotfiles/.config/zsh/zsh-abbr/zsh-abbr.zsh
PATH="$PATH:$HOME/dotfiles/.config/zsh/forgit/bin"

export EDITOR="nvim"
export TERMINAL="kitty"
export READER="mupdf -gl"
export VISUAL="nvim"
export VIDEO="mpv"
export IMAGE="/Applications/qView.app/Contents/MacOS/qView"
export OPENER="open"
export NVIMRC="~/.config/nvim/init.lua"
export PATH="$HOME/.emacs.d/bin:$PATH"
export GOPATH=$HOME/go-workspace # don't forget to change your path correctly!
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8
PATH=$PATH:~/.local/bin
PATH=$PATH:~/dotfiles/scripts
PATH=$PATH:~/dotfiles/scripts/presence
PATH=$PATH:~/.local/share
PATH=$PATH:/Users/ivan/dev/trackma-wrapper
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
export FZF_BASE="$HOME/.fzf"
export FZF_DEFAULT_COMMAND="rg ~ --files --hidden -g '!/Library/'"
export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
# export FZF_DEFAULT_OPTS="--no-mouse --height 50%"
export FZF_DEFAULT_OPTS="--no-mouse --height 50% --border -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),?:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy)'"
#DRACULA THEME FOR FZF
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
'
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
FD_OPTIONS="--follow --exclude .git --exclude node_modules -E Library -E go/"
alias rg="rg -g '!/Library/'" 

# .zshrc
autoload -U promptinit; promptinit
prompt pure
# eval "$(starship init zsh)"
# export STARSHIP_CONFIG=~/example/non/default/path/starship.toml
eval "$(zoxide init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

### File managing aliases

alias down='cd ~/Downloads'
alias doc='cd ~/Documents'
alias dev="cd ~/dev/"
alias ..='cd ..'
alias cd..="cd .."
alias mv="mv -i"
alias ls='exa'
alias ll='exa -Fal'
alias l='exa --long --grid'
alias lh="find . -mindepth 1 -maxdepth 1 -name '.*'|fzf"
alias ldir='exa -D'
alias tree='exa -T'
alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"
alias rd='rm -rf "$(exa -D| fzf)"'
alias cx='chmod +x "$(find . -maxdepth 1 -type f| fzf)"'
alias v='nvim'
alias nv='nvim'
alias lv='lvim'
alias vki="vim -c ':VimwikiIndex'"
alias vimwiki="vim -c ':VimwikiIndex'"
alias f="fzf"
alias ra="ranger"
# alias cd="z"
alias nvc="nvim ~/dotfiles/.config/zsh/.zshrc"
alias lvc="lvim ~/dotfiles/.config/zsh/.zshrc"
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
alias mpvq="mpv --no-video"

### yt-dlp aliases
# don't forget to download ffmpeg :/

alias ytdl="yt-dlp -f 'bv*+ba' --embed-thumbnail --embed-subs --merge-output-format mp4"
alias ytdl-mp3="yt-dlp --embed-metadata --extract-audio --audio-format mp3 --audio-quality 0 --embed-thumbnail"
alias ytdlist="yt-dlp -f 'bv*[height=1080]+ba'"
alias gedl='yt-dlp -f "bv*+ba" --embed-thumbnail --embed-subs --merge-output-format mp4 -P "$(find ~/good_edits -maxdepth 1 -type d|fzf)" "$(pbpaste)"'
alias fytdl='yt-dlp -f "bv*+ba" --embed-thumbnail --embed-subs --merge-output-format mp4 -P "$(fd . "/Users/ivan" --type d -E Library -E go/|fzf)" "$(pbpaste)"'
alias fytdl-mp3='yt-dlp --embed-metadata --extract-audio --audio-format mp3 --audio-quality 0 --embed-thumbnail -P "$(fd . "/Users/ivan" --type d -E Library -E go/|fzf)" "$(pbpaste)"'
alias fytdlist='yt-dlp -f "bv*[height=1080]+ba" -P "$(fd . "/Users/ivan" --type d -E Library -E go/|fzf)" "$(pbpaste)"'


### Other aliases

alias weather="curl -s wttr.in/Heilbronn"
alias icat="kitty +kitten icat"
alias pf='pfetch'
alias nf='neofetch --kitty ~/.config/neofetch/neofetch.jpeg --size 30%'
alias nft='neofetch --iterm2 ~/.config/neofetch/neofetch.jpeg'
alias py='python3.10'
alias pip='pip3'
alias u='exec zsh'
alias myip="curl ipinfo.io/ip"
alias ytm="ytfzf -m"
alias cf="change_folder"
alias opdf="open_pdf_fzf_mupdf"
alias of="open_with_fzf"
alias nvf="open_with_nvim"
alias nvj="open_with_nvim_java"
alias lvf="open_with_lvim"
alias lvj="open_with_lvim_java"
alias mpf="open_with_mpv"
alias msf="open_with_mpv_silent"
alias imf="open_image_fzf"
alias mpe="open_with_mpv_external"
alias nb="newsboat"
alias awho="animewho"
alias atrack="trackma.sh"
# alias pres=""
alias epy="python3.10 ~/dev/epy/epy.py"
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
alias pyenv="rm -rf venv/
python3.10 -m venv venv/
source venv/bin/activate
python3.10 -m pip install --require-virtualenv --progress-bar pretty -r requirements.txt
python3.10 -m pip cache purge"
alias watchgoodedits='cd "$(fd . "/Users/ivan/good_edits" --max-depth 1 --type d|fzf --cycle)" && mpv *'

### Life one ez mode

se() {du -a ~/dotfiles/scripts|awk '{print $2}'|fzf|xargs -r nvim}
sel() {du -a ~/dotfiles/scripts|awk '{print $2}'|fzf|xargs -r lvim}

cpf() {cp -v "$1" "/Users/ivan/Documents/$(ls ~/Documents/|fzf)/"}

# quickly access any alias or function i have
function qa() {
    CMD=$(
        (
            (alias)
            (functions | grep "()" | cut -d ' ' -f1 | grep -v "^_" )
        ) | fzf | cut -d '=' -f1
    );

    eval $CMD
}

function chst {
    [ -z $1 ] && echo "no args provided!" || (curl -s cheat.sh/$1 | bat --style=plain)
}

function rf() {
  if [[ "$#" -eq 0 ]]; then
    local files
    files=$(fd . --max-depth 1 --type f | fzf --multi)
    echo $files | xargs -I '{}' rm {} #we use xargs to capture filenames with spaces in them properly
  else
    command rm "$@"
  fi
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

# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

open_pdf_fzf_mupdf() {
    PDF_PATH=$(rg --files -t pdf| fzf --cycle)
    [[ -z $PDF_PATH ]] || (mupdf-gl "$PDF_PATH" &> /dev/null)
}

open_with_mpv() {
  VIDEO_PATH=$(rg --files -g '!anime/' -g '!for_editing/' -g '*.{mp4,mkv,webm,m4v}' | fzf --cycle)
    [[ -z $VIDEO_PATH ]] || (mpv "$VIDEO_PATH")
}

open_with_mpv_external() {
    cd /Volumes/EXTERNAL/chokerman
    VIDEO_PATH=$(rg --files -g '!csgo tweaks' -g '*.{mp4,mkv,webm,m4v}'| fzf --cycle)
    [[ -z $VIDEO_PATH ]] || (mpv "$VIDEO_PATH")
    cd ~/
}

open_with_mpv_silent() {
    VIDEO_PATH=$(rg --files -g '*.{mp3,flac,m4a}'| fzf --cycle)
    [[ -z $VIDEO_PATH ]] || (mpv --no-video --loop=inf "$VIDEO_PATH")
}

open_image_fzf() {
  IMAGE_PATH=$(rg --files -g '*.{jpg,png,jpeg,webp,gif}' | fzf --cycle)
    [[ -z $IMAGE_PATH ]] || (open "$IMAGE_PATH")
}

open_with_fzf() {
    FILE=$(rg --files | fzf --cycle)
    [[ -z "$FILE" ]] || (open "$FILE" &> /dev/null)
}

open_with_nvim() {
	FILE=$(fzf)
	[[ -z "$FILE" ]] || (nvim "$FILE")
}

open_with_nvim_java() {
	FILE=$(fd . '/Users/ivan' -e java -E '/Library/'| fzf --cycle)
	[[ -z "$FILE" ]] || (nvim -c ":set filetype=java" "$FILE")
}

open_with_lvim() {
	FILE=$(fzf)
	[[ -z "$FILE" ]] || (lvim "$FILE")
}

open_with_lvim_java() {
	FILE=$(fd . '/Users/ivan' -e java -E '/Library/'| fzf --cycle)
	[[ -z "$FILE" ]] || (lvim -c ":set filetype=java" "$FILE")
}

cote(){
  epy ~/Documents/ebooks/cote/$(ls ~/Documents/ebooks/cote|fzf --cycle)
}

ani(){
  python3 ~/dev/animdl/runner.py stream "$1" -r "$2"
}

fanime() {
  python3 ~/dev/animdl/runner.py stream "$1" -r "$2" --auto --index 1
}

animeg() {
  python3 ~/dev/animdl/runner.py grab "$1" -r "$2"|cut -d '"' -f 8|sed -e '1,2d'|pbcopy
}

animecover() {
BASE="$(curl -s -X POST -H "Content-Type: application/json" -d \
'{"query": "query($id:Int $search:String){Media (id: $id, search: $search, type: ANIME) {id coverImage {large}}}", "variables":{"search":"'"$*"'"}}' https://graphql.anilist.co/)"
pixcat thumbnail --size 1080 --align left $(printf "$BASE" | jq -r '.data.Media.coverImage.large')
}


char() {
BASE="$(curl -s -X POST -H "Content-Type: application/json" -d \
'{"query": "query($page:Int = 1 $id:Int $search:String $isBirthday:Boolean $sort:[CharacterSort]=[FAVOURITES_DESC]){Page(page:$page,perPage:20){pageInfo{total perPage currentPage lastPage hasNextPage}characters(id:$id search:$search isBirthday:$isBirthday sort:$sort){id name{userPreferred}image{large}}}}","variables":{"page": 1,"type": "CHARACTERS","search":"'"$*"'","sort": "SEARCH_MATCH"}}' \
https://graphql.anilist.co/)"
QUERY="$(printf "$BASE"|jq -r '.data.Page.characters[].name.userPreferred'|fzf)"
printf "\n" ; pixcat thumbnail --size 1080 --align left $(printf "$BASE"|jq -r '.data.Page.characters[]|select(.name.userPreferred == "'"$QUERY"'")|.image.large')
}

charmal() {
tmp=$(curl -s "https://myanimelist.net/character/$(curl -s "https://myanimelist.net/character.php?q=$1&cat=character"|pup '.picSurround'|grep href|cut -d '"' -f 2|cut -d'/' -f5-|fzf)"|pup '.borderClass'|grep -m 1 src|cut -d '"' -f4)
printf "\n" ; pixcat thumbnail --size 1080 --align left $tmp
}

cchar() {
  kitty +icat $(curl -s "https://you-zitsu.fandom.com/wiki/$(curl -s "https://you-zitsu.fandom.com/wiki/Category:Characters"|pup '.category-page__member'|rg href|awk 'NR%2==0 {print $0}'|awk '!/Category/ && !/small/'|cut -d '"' -f 2|cut -c 7-|sed -e 's/%C5%8D/ō/g' -e 's/%C5%AB/ū/g' -e 's/\ /_/g'|fzf|sed -e 's/ō/%C5%8D/g' -e 's/ū/%C5%AB/g')"|pup '.image-thumbnail'| cut -d '"' -f 2|head -n 1)
}

cchara() {
  kitty +icat $(curl -s "https://you-zitsu.fandom.com/wiki/$(curl -s "https://you-zitsu.fandom.com/wiki/Category:Characters"|pup '.category-page__member'|rg href|awk 'NR%2==0 {print $0}'|awk '!/Female/ && !/small/'|cut -d '"' -f 2|cut -c 7-|sed -e 's/%C5%8D/ō/g' -e 's/%C5%AB/ū/g' -e 's/\ /_/g'|fzf|sed -e 's/ō/%C5%8D/g' -e 's/ū/%C5%AB/g')"|pup '.image-thumbnail'|cut -d '"' -f 2|grep --invert-match -e 'scale-to-width' -e '</a>')
}



### Git

git config --global alias.st 'status -sb'
git config --global alias.ll 'log --oneline'
git config --global alias.last 'log -1 HEAD --stat'
git config --global alias.cm 'commit -m'
git config --global alias.rv 'remote -v'
git config --global alias.d 'diff'
git config --global alias.r 'reset --hard'
git config --global help.autocorrect 20
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global interactive.diffFilter "diff-so-fancy --patch"
git config --global color.ui true

git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"

git config --global color.diff.meta       "11"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.func       "146 bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"

alias g="git"
gc() {
  git clone "$1" && cd "$(basename "$1" .git)"
}
alias gaa="git add all"
alias gb="git branch"
alias gcm="git checkout master"
alias gf="git fetch"
alias gm="git merge"
alias gp="git pull"
alias grh="git reset --hard"
alias glog="git log --oneline --decorate --graph"

gci() {
  git clone "https://github.com/$(curl -s 'https://api.github.com/users/iamchokerman/repos' | jq -r '.[].full_name' | fzf)" && cd "$(basename "$_" .git)"
  }

function acp() {
git add .
git commit -m "$1"
git push
}


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
    tmp="$(ls|fzf)" 
    if [ -z "$tmp" ]; then
      break
    fi
    mpv "$tmp" 
    rm -vi "$tmp"
  done
  }

te () {
    dir="/Volumes/EXTERNAL/chokerman/media/tv_shows"
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

tl () {
    dir="/Users/ivan/Videos/tv_shows"
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


### Fzf functions

alias p="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

function fzf-env-vars() {
  local out
  out=$(env | fzf)
  echo $(echo $out | cut -d= -f2)
}

function delete-branches() {
  git branch |
    grep --invert-match '\*' |
    cut -c 3- |
    fzf --multi --preview="git log {} --" |
    xargs --no-run-if-empty git branch --delete --force
}

### Other

emoji() {
  emojis=$(curl -sSL 'https://git.io/JXXO7')
  selected_emoji=$(echo $emojis | fzf)
  echo "$selected_emoji" | awk '{print $1}' | pbcopy
} 
export PATH=$PATH:/Users/ivan/.spicetify

# fzf --bind 'f1:execute(less -f {}),ctrl-y:execute-silent(echo {} | pbcopy)+abort'

function pr-checkout() {
  local pr_number

  pr_number=$(
    gh api 'repos/pystardust/ani-cli/pulls' |
    jq --raw-output '.[] | "#\(.number) \(.title)"' |
    fzf |
    gsed 's/^#\([0-9]\+\).*/\1/'
  )

  if [ -n "$pr_number" ]; then
    gh pr checkout "$pr_number"
  fi
}
