# vim: ft=bash

# if not running interactively, don't do anythin
[[ $- != *i* ]] && return

# benchmarking
#zmodload zsh/zprof

# brew completions need to be done before compinit is called
if command -v brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# completion
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion::complete:*' gain-privileges 1 # allow completion on sudo
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${HOME}/local/share/.zshcompcache"
zstyle :compinstall filename "${HOME}/.zshrc"
zmodload zsh/complist
autoload -Uz compinit && compinit

# colors
autoload -U colors && colors 

# history configration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# additional zsh specific features:
# autocd: run cd if path is specified without command
# extendedglob: shell expansion
# nomatch: error if glob has no match
# notify: notify immediately on background job status change
setopt autocd extendedglob nomatch notify

# sets keyboard binding modes: 
# -e is emacs mode: standard stuff like ^a to beginning ^e to end etc
# -v is vi mode: if you know what this does it's too late. hope you have a will
bindkey -v
# set shorter timeout for mode switching
export KEYTIMEOUT=1
# vimkeys in tab complete 
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
# history search
bindkey "^R" history-incremental-search-backward
# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
# Use beam shape cursor on startup.
echo -ne '\e[5 q'
# Use beam shape cursor for each new prompt.
preexec() {
   echo -ne '\e[5 q'
}


### BINDINGS

# fzf bindings (for ^R fzf support for example)
if command -v fzf &>/dev/null; then
  if [ -f ~/.fzf.zsh ];then
    source ~/.fzf.zsh
  elif [ -f /usr/share/fzf/key-bindings.zsh ]; then # defaults
    source /usr/share/fzf/key-bindings.zsh
  elif [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then # uuboontoo
    source /usr/share/doc/fzf/examples/key-bindings.zsh
  elif [ -f /usr/share/fzf/shell/key-bindings.zsh ]; then # fedora
    source /usr/share/fzf/shell/key-bindings.zsh
  fi
fi


### INCLUDES
#
function include() {
  [[ -f "$1" ]] && source "$1"
}

include ~/.zshenv
include ~/.aliases

### COMPLETIONS

# setup prompt
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
  source <(starship completions zsh)
fi


# ssh agent manager
if command -v keychain &>/dev/null; then
  eval $(keychain --eval --quiet id_ed25519 id_rsa)
fi


# hook direnv completion
if command -v direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
fi

# podman
if command -v podman &>/dev/null; then
  source <(podman completion zsh)
  #compdef p='podman'
fi

# kubectl
if command -v kubectl &>/dev/null; then
  source <(kubectl completion zsh)
  #compdef k='kubectl'
fi

# minikube
if command -v minikube &>/dev/null; then
  source <(minikube completion zsh)
  #compdef mk='minikube'
fi

# kubecolor
if command -v kubecolor &>/dev/null; then
  #compdef kubecolor='kubectl'
  alias kc='kubecolor'
  #compdef kc='kubecolor'
fi

# terraform
if command -v terraform &>/dev/null; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C /opt/homebrew/bin/terraform terraform
fi



# misc comp stuff
# profiling trigger
#zprof


# dark mode toggle 
if command -v defaults &>/dev/null; then
    # this just fails if it's light mode /shrug
    export MACOS_STYLE=${"$(defaults read -g AppleInterfaceStyle &>/dev/null | tr -d '[:space:]')":-"Light"}
    export MACOS_STYLE_LOWER=$(echo ${MACOS_STYLE} | awk '{print tolower($0)}')
    # do stuff based on mode
    git config --global delta.syntax-theme OneHalf${MACOS_STYLE}
    ln -sf $HOME/.config/starship-${MACOS_STYLE_LOWER}.toml ${HOME}/.config/starship.toml
fi

