# vi mode
bindkey -v
export KEYTIMEOUT=1
# edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -s '^f' 'change_folder^M'

source "$HOME/dotfiles/.config/zsh/fzf-tab/fzf-tab.plugin.zsh"
source "$HOME/dotfiles/.config/zsh/zsh-system-clipboard/zsh-system-clipboard.zsh"
source "$HOME/dotfiles/.config/zsh/forgit/forgit.plugin.zsh"
# source "$HOME/dotfiles/.config/zsh/zsh-abbr/zsh-abbr.zsh"
source "$HOME/dotfiles/.config/zsh/custom/fzf.zsh"
source "$HOME/dotfiles/.config/zsh/custom/fd.zsh"
source "$HOME/dotfiles/.config/zsh/custom/aliases.zsh"
source "$HOME/dotfiles/.config/zsh/custom/functions.zsh"
source "$HOME/dotfiles/.config/zsh/custom/git.zsh"

export EDITOR="nvim"
export TERMINAL="kitty"
export READER="mupdf -gl"
export VISUAL="nvim"
export VIDEO="mpv"
export IMAGE="/Applications/qView.app/Contents/MacOS/qView"
export OPENER="open"
export PATH="$HOME/.emacs.d/bin:$PATH"
export GOPATH=$HOME/go-workspace # don't forget to change your path correctly!
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.spicetify
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$HOME/Library/Python/3.8/bin/
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8
PATH=$PATH:~/.local/bin
PATH=$PATH:/usr/bin
PATH=$PATH:~/dotfiles/scripts
PATH=$PATH:~/dotfiles/scripts/presence
PATH=$PATH:~/.local/share
PATH=$PATH:$HOME/.spicetify

autoload -U colors && colors
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.cache/zsh/history
autoload -U compinit && compinit -u
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# colorful man pages
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;32m'
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml
# very important, otherwise zoxide will not work
eval "$(zoxide init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# sketchybar stuff
function brew() {
  command brew "$@" 

  if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
    sketchybar --trigger brew_upgrade
  fi
}

function mas() {
  command mas "$@" 

  if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
    sketchybar --trigger brew_upgrade
  fi
}

function push() {
  command git push
  sketchybar --trigger git_push
}

