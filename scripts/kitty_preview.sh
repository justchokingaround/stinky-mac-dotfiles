#!/bin/bash

kitty +icat $(pbpaste)
read -p "Press enter to continue"
osascript -e 'quit app "Kitty"'
