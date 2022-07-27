# vi mode
bindkey -v
export KEYTIMEOUT=1
_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)
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

# very important, otherwise zoxide will not work
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

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
