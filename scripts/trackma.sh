#!/bin/sh
# I know there is a lot of code duplication in this script, I'll fix/clean it up later
if [[ "$OSTYPE" == "darwin"* ]]; then
	SED="gsed"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
	SED="sed"
fi

PROMPT=$(printf "watch\nbinge\nadd\ndelete\nlist\nupdate_episodes\nupdate_status\ninfo\naltname"|fzf)

main() {
  case $PROMPT in
    watch)
      INDEX=$(printf "filter watching\nls"|trackma|$SED 's/\x1b\[[0-9;]*m//g'|$SED -n '/^|/,${p;/results/q}'|$SED '$ d'|fzf|
        awk '{print $2}')
      ANIME="$(trackma -a 1 info "$INDEX"|head -n 1)"
      EPNUM="$(trackma -a 1 search "$ANIME"|grep -Eo '[0-9]{1,3} / [0-9]{1,3}'|cut -d "/" -f 1)"
      python3 ~/dev/animdl/runner.py stream "$ANIME" -r $((EPNUM+1))
      # ani-cli -a $((EPNUM+1)) "$ANIME"
      # mpv $(fd "$query" /Volumes/EXTERNAL/chokerman/media/anime)
      read -r -p "Do you want to set this episode as watched? [Y/n]" response
      if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
         trackma -a 1 update "$INDEX" $((EPNUM+1))
      fi
      ;;
    binge)
      INDEX=$(printf "filter watching\nls"|trackma|$SED 's/\x1b\[[0-9;]*m//g'|$SED -n '/^|/,${p;/results/q}'|$SED '$ d'|fzf|
        awk '{print $2}')
      ANIME="$(trackma -a 1 info "$INDEX"|head -n 1)"
      EPNUM="$(trackma -a 1 search "$ANIME"|grep -Eo '[0-9]{1,3} / [0-9]{1,3}'|cut -d "/" -f 1)"
      python3 ~/dev/animdl/runner.py stream "$ANIME" -r $((EPNUM+1))-
      # TODO: implement binge watch for ani-cli
      # ani-cli -a $((EPNUM+1)) "$ANIME"
      read -r -p "How many episodes have you watched? " EPWATCHED
      trackma -a 1 update "$INDEX" $((EPNUM+EPWATCHED))
      ;;
    add)
      read -p "What anime do you want to add? " ANIME
      ADDINDEX=$(printf "add $ANIME\n "|trackma|grep -E '[0-9]{1,2}:'|fzf|cut -d ':' -f1)
      printf "add $ANIME\n$ADDINDEX"|trackma > /dev/null
      ;;
    delete)
        INDEX="$(printf "ls"|trackma|$SED 's/\x1b\[[0-9;]*m//g'|$SED -n '/^|/,${p;/results/q}'|$SED '$ d'|fzf|awk '{print $2}')"
        printf "delete $INDEX\ny"|trackma > /dev/null
      ;;
    list)
        STATUS=$(printf "watching\ncompleted\nrewatching\npaused\ndropped\nplantowatch"|fzf)
        printf "filter $STATUS\nls"|trackma|$SED 's/\x1b\[[0-9;]*m//g'|$SED -n '/^|/,${p;/results/q}'|$SED '$ d'
      ;;
    update_episodes)
        STATUS=$(printf "watching\ncompleted\nrewatching\npaused\ndropped\nplantowatch"|fzf)
        INDEX="$(printf "filter $STATUS\nls"|trackma|$SED 's/\x1b\[[0-9;]*m//g'|
          $SED -n '/^|/,${p;/results/q}'|$SED '$ d'|fzf|awk '{print $2}')"
        read -p "How many episodes have you watched? " NEWEPISODE
        printf "filter $STATUS\nupdate $INDEX $NEWEPISODE"|trackma > /dev/null
        ;; 
    update_status)
        STATUS=$(printf "watching\ncompleted\nrewatching\npaused\ndropped\nplantowatch"|fzf)
        INDEX="$(printf "filter $STATUS\nls"|trackma|$SED 's/\x1b\[[0-9;]*m//g'|
          $SED -n '/^|/,${p;/results/q}'|$SED '$ d'|fzf|awk '{print $2}')"
        NEWSTATUS=$(printf "watching\ncompleted\nrewatching\npaused\ndropped\nplantowatch"|fzf)
        printf "filter $STATUS\nstatus $INDEX $NEWSTATUS"|trackma > /dev/null
      ;;
    info)
        STATUS=$(printf "watching\ncompleted\nrewatching\npaused\ndropped\nplantowatch"|fzf)
        INDEX="$(printf "filter $STATUS\nls"|trackma|$SED 's/\x1b\[[0-9;]*m//g'|
            $SED -n '/^|/,${p;/results/q}'|$SED '$ d'|fzf|awk '{print $2}')"
        printf "filter $STATUS\ninfo $INDEX"|trackma|sed -n '/https/,/Status/p'|sed -e 's/<[^>]*>//g'
        ;;
    altname)
        INDEX="$(printf "ls"|trackma|$SED 's/\x1b\[[0-9;]*m//g'|$SED -n '/^|/,${p;/results/q}'|$SED '$ d'|fzf|awk '{print $2}')"
        read -p "What is the new name? " NEWNAME
        printf "altname $INDEX $NEWNAME"|trackma > /dev/null
        ;;
  esac
}

main

# printf "filter $STATUS\ninfo $INDEX"|trackma
# NEWSTATUS=$(printf "watching\ncompleted\nrewatching\npaused\ndropped\nplantowatch"|fzf)
# printf "filter $STATUS\nstatus $INDEX $NEWSTATUS"|trackma
# printf "del 1\ny"|trackma
