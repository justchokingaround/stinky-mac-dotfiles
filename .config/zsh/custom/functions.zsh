### Life one ez mode

# quickly edit or run scripts from my scripts directory
se() {
  var=$(gum choose "edit" "run" --item.foreground="360" --cursor="→ ")
  script=$(find $HOME/dev/sh_scripts -type f|sort|fzf --height=12 --cycle -d"/" --with-nth=6.. --reverse)
  case $var in
    edit)
      printf "%s\n" "$script"|xargs nvim ;;
    run)
      sh $script ;;
  esac
}

# quickly edit zsh config stuff
nvs() {
  var=$(gum choose "zshrc" "functions" "aliases" "zshenv" --item.foreground="360" --cursor="→ ")
  case $var in
    zshrc)
      $EDITOR $HOME/dotfiles/.config/zsh/.zshrc ;;
    functions)
      $EDITOR $HOME/dotfiles/.config/zsh/custom/functions.zsh ;;
    aliases)
      $EDITOR $HOME/dotfiles/.config/zsh/custom/aliases.zsh ;;
    zshenv)
      $EDITOR $HOME/dotfiles/.config/zsh/.zshenv ;;
  esac
}

# quickly edit nvim config stuff
nvc() {
  file=$(fd . "$HOME/dotfiles/.config/nvim/lua/user" -t f -d 1|fzf -d"/" --with-nth -1.. --height=95%)
  [ -z "$file" ] || $EDITOR $file
}

# quickly access any alias or function i have
qa() { eval $( (alias && functions|sed -nE 's@^([^_].*)\(\).*@\1@p')|cut -d"=" -f1|fzf --reverse) }

# get cheat sheet for a command
chst() {
  [ -z "$*" ] && printf "Enter a command name: " && read -r cmd || cmd=$*
  curl -s cheat.sh/$cmd|bat --style=plain
}

# create a directory and enter it
mkcd() { mkdir -p "$1" && cd "$1"; } 

# use fzf with tree preview to go into a directory
change_folder() {
  CHOSEN=$(fd '.' -d 1 -H -t d $DIR|fzf --cycle --height=95% --preview="exa -T {}" --reverse)
  [ -z $CHOSEN ] && return 0 || cd "$CHOSEN" && [ $(ls|wc -l) -le 60 ] && (pwd; ls)
}

# search for file and go into its directory
ji() {
   file=$(fzf -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

open_with_mpv() {
  VIDEO_PATH=$(rg --files -g '!anime/' -g '!for_editing/' -g '*.{mp4,mkv,webm,m4v}' | fzf --cycle)
    [[ -z $VIDEO_PATH ]] || (mpv "$VIDEO_PATH")
}

open_with_nvim() {
  FILE=$(rg --files -g '!*.{gif,png,jp(e)g,mp4,mkv,webm,m4v,mov,MOV}'|fzf --reverse --height 95%)
  [[ -z $FILE ]] || nvim "$FILE"
}

open_with_nvim_filetype() {
  [ -z "$*" ] && filetype=$(gum filter --indicator="→ " \
    --placeholder="Choose a filetype" \
    --indicator.foreground="360" --text.foreground="360" \
    < ~/dev/sh_scripts/extensions.txt) || filetype=$*
  [ -z "$filetype" ] || FILE=$(rg --files -g "*.$filetype"|
    sort|fzf --cycle --reverse --height 95% -0)
  [[ -z "$FILE" ]] || nvim "$FILE"
}

animes(){
  animdl stream "$1" -r "$2"
}

animeg() {
  animdl grab "$1" -r "$2" --index 1|sed -nE 's|.*stream_url": "(.*)".*|\1|p'|pbcopy
}

### Fzf functions

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

### Other

emoji() {
  emojis=$(curl -sSL 'https://git.io/JXXO7')
  selected_emoji=$(echo $emojis|fzf)
  echo "$selected_emoji"|awk '{print $1}'|pbcopy
} 

# pick an image with fzf and copy it to the clipboard
# ic = image copy
ic() {
  image=$(fd -t f -d 1 --extension png --extension jpg --extension jpeg --extension webm|
    fzf -0 --cycle --preview="kitty +kitten icat --clear --transfer-mode file; \
  kitty +kitten icat --place "190x12@10x10" --scale-up --transfer-mode file {}")
  [ -z "$image" ] || imgcopy "$image"
}

# pick and image with fzf and quickly share it
# is = image share
is() {
  image=$(fd -t f -d 1|fzf --cycle --preview="kitty +kitten icat --clear --transfer-mode file; \
  kitty +kitten icat --place "190x12@10x10" --scale-up --transfer-mode file {}")
  [ -z "$image" ] || printf $(curl -# "https://0x0.st" -F "file=@${image}")|pbcopy
}

# Update all Wallpapers
wallpaper() {
  sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '$(readlink -f $1)'" && killall Dock 
}

choose_wallpaper() {
  sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db \
    "update data set value = '$(find $HOME/Pictures/wallpapers -type f|
    fzf --cycle -d"/" --with-nth=6.. --preview="kitty icat \
    --place 60x40@72x10 --transfer-mode file {}")'" && killall Dock 
}

