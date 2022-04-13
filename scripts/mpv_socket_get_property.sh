#!/bin/sh

SOCKET='/tmp/mpvsocket'

# pass the property as the first argument
mpv_communicate() {
  printf '{ "command": ["get_property", "%s"] }\n' "$1" | socat - "${SOCKET}" | jq -r ".data"
}

WORKING_DIR="$(mpv_communicate "working-directory")"
FILEPATH="$(mpv_communicate "path")"

printf "%s/%s\n" "$WORKING_DIR" "$FILEPATH"
