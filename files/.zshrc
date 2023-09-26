# vim: ft=bash

# set fpath to zsh specific thing
#fpath=( "${ZDOTDIR:-$HOME}/.zfunctions" $fpath )

# if not running interactively, don't do anythin
[[ $- != *i* ]] && return

# completion
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion::complete:*' gain-privileges 1 # allow completion on aliases
zstyle :compinstall filename '~/.zshrc'
zmodload zsh/complist
autoload -Uz compinit
compinit

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
setopt autocd extendedglob nomatch notify COMPLETE_ALIASES

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

# fzf customisation
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# ssh agent manager
#eval $(keychain --eval --quiet id_ed25519 id_rsa)

# gpg key
export GPG_TTY=$(tty)

### COMPLETIONS & BINDINGS

# hook direnv completion
if direnv --version &>/dev/null; then
  eval "$(direnv hook zsh)"
fi

# kubectl
if kubectl --version &>/dev/null; then
  source <(kubectl completion zsh)
  compdef kubecolor=kubectl
  compdef kc=kubecolor
fi

# fzf bindings (for ^R fzf support for example)
if fzf --version &>/dev/null; then
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

# load aliases
source ~/.aliases
# load shell env
if [ -f "$HOME/.zshenv" ]; then
  source ~/.zshenv
fi

# setup prompt
if starship --version &>/dev/null; then
  eval "$(starship init zsh)"
  source <(starship completions zsh)
fi


