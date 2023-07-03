#
# swap escape and capslock keys on xorg based systems
# setxkbmap -option caps:swapescape

# disable C-s hanging the terminal
# see more: https://unix.stackexchange.com/questions/72086/ctrl-s-hangs-the-terminal-emulator
stty -ixon

# disable case sensitive compltion 
bind 'set completion-ignore-case on'

# load bash env environment variables
source $HOME/.bash_env


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

### COMPLETIONS & BINDINGS

# fzf bindings (for ^R fzf support for example)
if [ -f /usr/share/fzf/key-bindings.bash ]; then # defaults
  source /usr/share/fzf/key-bindings.bash
elif [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then # uuboontoo
  source /usr/share/doc/fzf/examples/key-bindings.bash
elif [ -f /usr/share/fzf/shell/key-bindings.bash ]; then # fedora
  source /usr/share/fzf/shell/key-bindings.bash
fi

# hook direnv completion
if direnv --version &>/dev/null; then
  eval "$(direnv hook bash)"
fi

# hook hcloud completion
if hcloud completion bash &>/dev/null; then
  source <(hcloud completion bash)
fi


# typer completion (python package cli for writing cli applications, trippy)
if [ -f ~/.bash_completions/typer.sh ]; then 
  source ~/.bash_completions/typer.sh
fi

# kubectl completion
if kubectl --version &>/dev/null; then
  source <(kubectl completion bash)
  complete -F __start_kubectl kc
fi

source ~/.aliases
. "$HOME/.cargo/env"
