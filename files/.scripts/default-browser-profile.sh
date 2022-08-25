#!/usr/bin/env sh
if [ "$BROWSER_PROFILE" = "ask" ]; then
  BROWSER_PROFILE=$(cat ~/.config/.browserprofiles | rofi -dmenu -sep ',' -p '🌎')
elif [ "$BROWSER_PROFILE" = "" ]; then
  BROWSER_PROFILE="personal"
fi

firefox -P ${BROWSER_PROFILE} "$@"
