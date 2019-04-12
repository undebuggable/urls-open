#!/bin/sh

#DATETIME_NOW=$(date +"%Y-%m-%d-%H-%M-%S")
#DIR_USERDATA=$HOME"/.config/urls-open-chromium-"$DATETIME_NOW
COUNT=0
CMD_CHROMIUM=""
USE_OPEN=false
PATH_INPUT=$1

function get_command_chromium () {
  if [ -x "$(command -v chromium-browser)" ]; then
    # e.g. Linux
    CMD_CHROMIUM="chromium-browser --incognito --new-window"
  elif [ -x "$(command -v open)" ]; then
    # e.g. MacOS
    USE_OPEN=true
    CMD_CHROMIUM="urls-open-chromium.scpt"
  else
    echo "Unable to open Chromium. Exiting."
    exit 1
  fi
}

function concat_command_chromium () {
  while read url_line; do
    url_trimmed=${url_line//[[:blank:]]/}
    # not an empty string
    if [ ! -z "$url_trimmed" ]; then
      # not a commented out URL
      if [[ $url_trimmed != \#* ]]; then
        if [ $USE_OPEN = true ]; then
          CMD_CHROMIUM=$CMD_CHROMIUM" "$url_trimmed
        else
          CMD_CHROMIUM=$CMD_CHROMIUM" "$url_trimmed
        fi
        COUNT=$(( $COUNT + 1 ))
      fi
    fi
  done <$PATH_INPUT
  if [ $COUNT -gt 0 ]; then
    echo $CMD_CHROMIUM
#    $CMD_CHROMIUM </dev/null &>/dev/null &
    $CMD_CHROMIUM
  else
    echo "No URLs found in the input file. Exiting."
    exit 1
  fi
}

get_command_chromium
concat_command_chromium
