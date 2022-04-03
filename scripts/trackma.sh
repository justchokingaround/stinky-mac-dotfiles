#!/bin/sh
if [ -z "$*" ]; then
  read -p "> " query
else
  query=$*
fi

INDEX="$(trackma -a 1 search "$query"|awk '{print $2}'|sed '2q;d')"
EPNUM="$(trackma -a 1 search "$query"|grep -Eo '[0-9]{1,3} / [0-9]{1,3}'|cut -d "/" -f 1)"
ANIME="$(trackma -a 1 info "$INDEX"|head -n 1)"

 python3.9 ~/dev/animdl/runner.py stream "$ANIME" -r $((EPNUM+1)) --auto --index 1
# ani-cli -a $((EPNUM+1)) "$ANIME"
# mpv $(fd "$query" /Volumes/EXTERNAL/chokerman/media/anime)

read -r -p "Do you want to set this episode as watched? [Y/n]" response
if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
   trackma -a 1 update "$INDEX" $((EPNUM+1))
fi
