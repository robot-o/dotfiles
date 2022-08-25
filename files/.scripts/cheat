#!/usr/bin/env bash
set -eo pipefail

# select delim based on arg, use ~ for generic question
case "$1" in
	a | ask | -a)
		req_delim="~"
		;;
	"")
		req_delim="/"
		;;
	*)
		;;
esac

# instead of manually maintaing a list, we just get it from cht.sh
# a second GET is not a big deal considering you can't really use this offline
selected=$(curl -s https://cht.sh/:list | fzf)

echo "selected: ${selected}"
read -r -p "query: " query
case "${query}" in
	# only use the selected cheat sheet, and trim rest of request including '/' 
	# as it messes up the search
	"")
		req_delim=""
		query=""
		;;
	*)
		# convert spaces to '+' for the actual get request
		query=$(echo "${query}" | tr ' ' '+')
		;;
esac


# insert the appropriate delimiter for search / topic requests
request="${selected}${req_delim}${query}"

# build command including piping into pager (bat in this case)
cmd="curl -s \"https://cht.sh/${request}\" | bat --paging=always"

# run in ephemeral window if we're inside tmux
if [[ -n "$TMUX" ]]; then
	tmux neww bash -c "eval ${cmd} & while [ : ]; do sleep 1; done"
else
	eval "${cmd}"
fi

exit 0
