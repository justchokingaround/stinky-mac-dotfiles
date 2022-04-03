#!/bin/sh
if [ -z "$*" ]; then
  read -p "> " CHARACTER
else
  CHARACTER=$*
fi
BASE="$(curl -s -X POST -H "Content-Type: application/json" -d \
'{"query": "query($page:Int = 1 $id:Int $search:String $isBirthday:Boolean $sort:[CharacterSort]=[FAVOURITES_DESC]){Page(page:$page,perPage:20){pageInfo{total perPage currentPage lastPage hasNextPage}characters(id:$id search:$search isBirthday:$isBirthday sort:$sort){id name{userPreferred}image{large}}}}","variables":{"page": 1,"type": "CHARACTERS","search":"'"$CHARACTER"'","sort": "SEARCH_MATCH"}}' \
https://graphql.anilist.co/)"
QUERY="$(printf "$BASE"|jq -r '.data.Page.characters[].name.userPreferred'|fzf)"
ID=$(printf "$BASE"|jq -r '.data.Page.characters[]|select(.name.userPreferred == "'"$QUERY"'")|.id')
curl -s "https://anilist.co/character/$ID"|htmlq --text
