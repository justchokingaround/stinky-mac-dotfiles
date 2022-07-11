### Life one ez mode

se() {du -a ~/dotfiles/scripts|awk '{print $2}'|fzf|xargs -r nvim}
cpf() {cp -v "$1" "$HOME/Documents/$(ls ~/Documents/|fzf)/"}

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

app() {
    sapp_list=$(find /System/Applications -maxdepth 3 -type d |
                grep '\.app$' |
                sed 's/\/System\/Applications\///' |
                sed 's/\.app$//' |
                sed 's/^/ : /')
    aapp_list=$(find /Applications -maxdepth 3 -type d |
                grep '\.app$' |
                sed 's/\/Applications\///' |
                sed 's/\.app$//' |
                sed 's/^/ : /')
    uapp_dest="/Users/$(whoami)/Applications"
    uapp_dest_sed="s/\/Users\/$(whoami)\/Applications\///"
    # echo $uapp_dest_sed
    uapp_list=$(find $uapp_dest -maxdepth 3 -type d |
                grep '\.app$' |
                sed $uapp_dest_sed |
                sed 's/\.app$//' |
                sed 's/^/ : /')
    # echo -e $uapp_list
    app_path=$(echo -e "$sapp_list\n$aapp_list\n$uapp_list" | fzf --query="$1" --prompt="App > " --exit-0)
    if [ -n "$app_path" ]; then
        open_path_u="s/U::/\/Users\/$(whoami)\/Applications\//"
        open_path=$(echo "$app_path" |
                    sed 's/ : /\/System\/Applications\//' |
                    sed 's/ : /\/Applications\//' |
                    sed $open_path_u)
        # echo $open_path
        open -a "$open_path.app"
        # preventing open command returns not 0
        :
    fi
}

function chst {
    [ -z $1 ] && echo "no args provided!" || (curl -s cheat.sh/$1 | bat --style=plain)
}

function rf() {
  if [[ "$#" -eq 0 ]]; then
    local files
    files=$(fd . --max-depth 1 --type f | fzf --multi)
    echo $files | xargs -I '{}' rm {}
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

open_with_mpv_quiet() {
  VIDEO_PATH=$(rg --files -g '!Library/' -g '!for_editing/' -g '*.{mp4,mkv,webm,m4v}' | fzf --cycle)
    [[ -z $VIDEO_PATH ]] || (mpv --no-video --loop="inf" "$VIDEO_PATH")
}

open_with_mpv_silent() {
    VIDEO_PATH=$(rg --files -g '*.{mp3,flac,m4a}'| fzf --cycle)
    [[ -z $VIDEO_PATH ]] || (mpv --no-video --loop=inf "$VIDEO_PATH")
}

open_with_iina() {
  VIDEO_PATH=$(rg --files -g '!anime/' -g '!for_editing/' -g '*.{mp4,mkv,webm,m4v}' | fzf --cycle)
    [[ -z $VIDEO_PATH ]] || (iina "$VIDEO_PATH")
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
	FILE=$(fzf --reverse --height 50%)
        [[ -z "$FILE" ]] || nvim "$FILE" && cd $(dirname "$FILE") 
}

open_with_nvim_java() {
	FILE=$(fd . '/Users/justchokingaround' -e java -E '/Library/'| fzf --cycle)
	[[ -z "$FILE" ]] || (nvim -c ":set filetype=java" "$FILE")
}

open_with_lvim() {
	FILE=$(fzf)
	[[ -z "$FILE" ]] || (lvim "$FILE")
}

open_with_lvim_java() {
	FILE=$(fd . '/Users/justchokingaround' -e java -E '/Library/'| fzf --cycle)
	[[ -z "$FILE" ]] || (lvim -c ":set filetype=java" "$FILE")
}

cote(){
  epy ~/Documents/ebooks/cote/$(ls ~/Documents/ebooks/cote|fzf --cycle)
}

ani(){
  animdl stream "$1" -r "$2"
}

fanime() {
  animdl stream "$1" -r "$2" --auto --index 1
}

animeg() {
  animdl grab "$1" -r "$2"|cut -d '"' -f 8|sed -e '1,2d'|pbcopy
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
	page=$(curl -s "https://you-zitsu.fandom.com/wiki/Category:Characters"|awk -F '"' '/category-page__member-link/&&!/Category/ {print $2,$6}'|fzf --with-nth 2..|awk '{print $1}')
	pixcat "$(curl -s "https://you-zitsu.fandom.com$page"|awk -F '"' '/pi-image-thumbnail/ {print $2}')"
}

cchara() {
	kitty +icat $(curl -s "https://you-zitsu.fandom.com$(curl -s "https://you-zitsu.fandom.com/wiki/Category:Characters"|pup '.category-page__member'|awk -F '"' '/category-page__member-link/&&!/Category/ {print $2,$6}'|fzf --with-nth 2..|awk '{print $1}')"|awk -F '"' '/image-thumbnail/&&/src/ {print $2}')
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
    dir="/Users/justchokingaround/Videos/tv_shows"
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
export PATH=$PATH:/Users/justchokingaround/.spicetify

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

