# ~/.bashrc
[[ $- != *i* ]] && return

if [ -e $HOME/.bash_aliases ]; then
    source $HOME/.bash_aliases
fi

export EDITOR="nvim"
export TERMINAL="alacritty"
export TERMALT="st"
export browser="firefox"
export BROWSER="firefox"
export PATH="/home/ivan/scripts/:$PATH"
export FILE="ranger"
export NVIMRC="~/.config/nvim/init.lua"

# fzf superpower
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"


# spring cleaning
# ---------------
# XDG
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
# npm
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
# npm
export npm_config_prefix="$HOME/.local"
# wget
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'
# ------------------
# doom emacs
export PATH="$PATH:$HOME/.emacs.d/bin/"

eval "$(starship init bash)"
. "$HOME/.cargo/env"
