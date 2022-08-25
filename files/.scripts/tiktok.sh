#!/usr/bin/env bash
if [ "$#" -lt 2 ]; then
  echo ' not enough arguments. tiktok.sh <text> <output_file> [optional: --play]'
  exit 1
fi

if [ -z "$1" ]; then
  echo " no input specified"
  exit 1
fi

input_text="$1"
input_text="${input_text// /+}"
echo "input text $input_text"
shift
if [ -z "$1" ]; then
  echo "no output file specified"
  exit 1
fi
output_file="$1"
echo "output file $output_file"
shift
echo "args = $1"

curl -X POST "https://api16-normal-useast5.us.tiktokv.com/media/api/text/speech/invoke/?text_speaker=en_us_002&req_text=${input_text}" | jq .data.v_str | base64 -di > "$output_file"

if [ "$1" == "--play" ];then 
  vlc "$output_file"
fi
exit 0
