#!/bin/sh

read -t 5 -p "Prompt " RESP
if [[ $? -gt 128 ]] ; then
    echo -e "\nTimeout"
else
    echo "Response = \"$RESP\""  # adding quotes so empty strings are obvious
fi
