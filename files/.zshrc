# vim: ft=bash

# if not running interactively, don't do anythin
[[ $- != *i* ]] && return

# benchmarking
if [[ "$ZSH_BENCHMARKING_ENABLED"  == "true" ]]; then
  zmodload zsh/zprof
fi

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
zstyle ':completion:*' cache-path "${HOME}/.local/share/.zshcompcache"
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
if [[ $ZSH_KEYBIND_MODE == "e" ]]; then
  bindkey -e
else
  bindkey -v
fi

# commandline editor editing

autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

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

function include() {
  [[ -f "$1" ]] && source "$1"
}

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
  compdef k='kubectl'
  # kubecolor
  if command -v kubecolor &>/dev/null; then
    alias kubectl='kubecolor'
    compdef kubecolor='kubectl'
  fi
fi

# minikube
if command -v minikube &>/dev/null; then
  source <(minikube completion zsh)
  #compdef mk='minikube'
fi

# terraform
if command -v terraform &>/dev/null; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C $(which terraform) terraform
fi

# autocompletions on macos
if command -v brew &>/dev/null; then
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi


# dark mode toggle
STYLE_MODE=Dark
STYLE_MODE_LOWER=dark

# get from macos
# TODO: add this for generic linux
if command -v defaults &>/dev/null; then
    # this just fails if it's light mode /shrug
    STYLE_MODE=${"$(defaults read -g AppleInterfaceStyle &>/dev/null | tr -d '[:space:]')":-"Light"}
    STYLE_MODE_LOWER=$(echo ${STYLE_MODE} | awk '{print tolower($0)}')
fi

# TODO: fix this so it fails gracefully
# do stuff based on mode
# git config --global delta.syntax-theme OneHalf${STYLE_MODE}
ln -sf $HOME/.config/starship-${STYLE_MODE_LOWER}.toml ${HOME}/.config/starship.toml &>/dev/null
#export BAT_THEME="OneHalf${STYLE_MODE}"
export BAT_THEME="tokyonight_night"

if [[ "$ZSH_BENCHMARKING_ENABLED"  == "true" ]]; then
  zprof
fi

