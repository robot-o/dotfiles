## my customizations
# swap escape and capslock keys
# setxkbmap -option caps:swapescape

# disable C-s hanging the terminal
# see more: https://unix.stackexchange.com/questions/72086/ctrl-s-hangs-the-terminal-emulator
stty -ixon

# disable case sensitive compltion 
bind 'set completion-ignore-case on'

# load bash env environment variables
source $HOME/.bash_env

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc
