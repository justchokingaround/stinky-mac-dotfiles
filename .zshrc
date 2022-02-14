alias ls='lsd'
alias aw='ani-cli'
alias awc='ani-cli -c'
alias awu='ani-cli -U'
alias u='exec zsh'
alias cat='lolcat'
alias v='nvim'
alias nv='nvim'
alias ..='cd ..'
alias down='cd ~/Downloads'
alias doc='cd ~/Documents'
alias ani='cd ~/anime'
alias lofi='cd ~/git/Rofi-Beats/ ; ./rofi-beats'
alias at='./ani-cli'
alias nf='neofetch'
alias cz='nvim ~/.zshrc'
alias syncplay='/Applications/Syncplay.app/Contents/MacOS/Syncplay'

 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nvim'
 else
   export EDITOR='vim'
 fi

export NVIMRC="~/.config/nvim/init.lua"

source /Users/ivan/.config/broot/launcher/bash/br
eval "$(starship init zsh)"
