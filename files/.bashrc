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

function include() {
  [[ -f "$1" ]] && source "$1"
}

include ~/.aliases

### COMPLETIONS & BINDINGS

# fzf bindings (for ^R fzf support for example)
if command -v fzf &>/dev/null; then
  if [ -f /usr/share/fzf/key-bindings.bash ]; then # defaults
    source /usr/share/fzf/key-bindings.bash
  elif [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then # uuboontoo
    source /usr/share/doc/fzf/examples/key-bindings.bash
  elif [ -f /usr/share/fzf/shell/key-bindings.bash ]; then # fedora
    source /usr/share/fzf/shell/key-bindings.bash
  fi
fi


# hook direnv completion
if command -v direnv &>/dev/null; then
  eval "$(direnv hook bash)"
fi

# hook hcloud completion
if command -v hcloud &>/dev/null; then
  source <(hcloud completion bash)
fi

# hook terraform completion
if command -v terraform &>/dev/null; then
  complete -C /opt/homebrew/bin/terraform terraform
fi

# typer completion (python package cli for writing cli applications, trippy)
if [ -f ~/.bash_completions/typer.sh ]; then 
  source ~/.bash_completions/typer.sh
fi

# kubectl completion
if command -v kubectl &>/dev/null; then
  source <(kubectl completion bash)
  complete -F __start_kubectl kc
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# setup prompt
if command -v starship &>/dev/null; then
  eval "$(starship init bash)"
fi


