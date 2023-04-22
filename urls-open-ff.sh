#!/bin/sh


#DATETIME_NOW=$(date +"%Y-%m-%d-%H-%M-%S")
#DIR_USERDATA=$HOME"/.mozilla/firefox/urls-open-ff-"$DATETIME_NOW
COUNT=0
CMD_FIREFOX=""
USE_OPEN=false
PATH_INPUT=$1


function get_command_firefox () {
  if [ -x "$(command -v firefox)" ]; then
    # e.g. Linux
    
    PROFILE_FIREFOX=$(mktemp -d);
    echo $PROFILE_FIREFOX;
    echo '{"created": $(date +%s),"firstUse":null}' > ${PROFILE_FIREFOX}/times.json;
    
    # is Firefox process already running?
    PID_FIREFOX=$(pidof firefox)
    if [ ! -z "$PID_FIREFOX" ]; then
      # yes
      CMD_FIREFOX="firefox --profile $PROFILE_FIREFOX -private -new-window -new-tab -url"
    else
      # no
      CMD_FIREFOX="firefox --profile $PROFILE_FIREFOX -private -new-window -new-tab -url"
    fi
  elif [ -x "$(command -v open)" ]; then
    # e.g. MacOS
    USE_OPEN=true
    # is Firefox process already running?
    PID_FIREFOX=$(pidof firefox)
    if [ ! -z "$PID_FIREFOX" ]; then
      CMD_FIREFOX="urls-open-ff.scpt"
    else
      # no
      CMD_FIREFOX="urls-open-ff.scpt"
    fi
  else
    echo "Unable to open Firefox. Exiting."
    exit 1
  fi
}

function concat_command_firefox () {
  while read url_line; do
    url_trimmed=${url_line//[[:blank:]]/}
    # not an empty string
    if [ ! -z "$url_trimmed" ]; then
      # not a commented out URL
      if [[ $url_trimmed != \#* ]]; then
        if [ $USE_OPEN = true ]; then
          CMD_FIREFOX=$CMD_FIREFOX" "$url_trimmed
        else
          CMD_FIREFOX=$CMD_FIREFOX" "$url_trimmed
        fi
        COUNT=$(( $COUNT + 1 ))
      fi
    fi
  done <$PATH_INPUT
  if [ $COUNT -gt 0 ]; then
    echo $CMD_FIREFOX
    $CMD_FIREFOX </dev/null &>/dev/null &
#    $CMD_FIREFOX
  else
    echo "No URLs found in the input file. Exiting."
    exit 1
  fi
}

get_command_firefox
concat_command_firefox
