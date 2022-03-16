alias g='cd "$(ls -d */| fzy)"'
alias trackma='trackma -a 1'
alias r='rm -rf "$(fzf)"'
alias python='python3'
alias pip='pip3'
alias ls='lsd'
alias aw='ani-cli'
alias awc='ani-cli -c'
alias awu='ani-cli -U'
alias u='exec zsh'
#alias cat='lolcat'
alias v='nvim'
alias nv='nvim'
alias ..='cd ..'
alias down='cd ~/Downloads'
alias doc='cd ~/Documents'
alias ani='cd ~/anime'
alias lofi='cd ~/git/Rofi-Beats/ ; ./rofi-beats'
alias at='./ani-cli'
alias nf='neofetch | lolcat'
alias cz='nvim ~/.zshrc'
alias syncplay='/Applications/Syncplay.app/Contents/MacOS/Syncplay'

export EDITOR="nvim"
export NVIMRC="~/.config/nvim/init.lua"
export PATH="$HOME/.emacs.d/bin:$PATH"
export LC_ALL=fr_FR.UTF-8

eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

####
#GIT
####

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




######
#MEDIA
######

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

##############
#FZF FUNCTIONS
##############

alias p="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}
# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}
# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}


######
#OTHER
######
# Install or open the webpage for the selected application 
# using brew cask search as input source
# and display a info quickview window for the currently marked application 
install() {
    local token
    token=$(brew search --casks "$1" | fzf-tmux --query="$1" +m --preview 'brew info {}')
                    
    if [ "x$token" != "x" ]                                                                
    then             
        echo "(I)nstall or open the (h)omepage of $token"
        read input                             
        if [ $input = "i" ] || [ $input = "I" ]; then    
            brew install --cask $token                   
        fi                                                                                    
        if [ $input = "h" ] || [ $input = "H" ]; then                                         
            brew home $token                     
        fi                                           
    fi                             
}
# Uninstall or open the webpage for the selected application 
# using brew list as input source (all brew cask installed applications) 
# and display a info quickview window for the currently marked application
uninstall() {                                                                     
    local token                                                                   
    token=$(brew list --casks | fzf-tmux --query="$1" +m --preview 'brew info {}')
                                                                                  
    if [ "x$token" != "x" ]                                                       
    then                                                                          
        echo "(U)ninstall or open the (h)omepae of $token"                        
        read input                                                                
        if [ $input = "u" ] || [ $input = "U" ]; then                             
            brew uninstall --cask $token                                          
        fi                                                                        
        if [ $input = "h" ] || [ $token = "h" ]; then                             
            brew home $token                                                      
        fi                                                                        
    fi                                                                            
}                                                                                 
emoji() {
  emojis=$(curl -sSL 'https://git.io/JXXO7')
  selected_emoji=$(echo $emojis | fzf)
  echo "$selected_emoji" | awk '{print $1}' | pbcopy
} 
