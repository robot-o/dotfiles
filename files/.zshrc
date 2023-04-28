#!/usr/bin/env zsh
#
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
zstyle :compinstall filename '/home/user/.zshrc'
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

# load aliases
source ~/.aliases

# fzf customisation
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# ssh agent manager
#eval $(keychain --eval --quiet id_ed25519 id_rsa)

# gpg key
export GPG_TTY=$(tty)

# hook direnv completion
eval "$(direnv hook zsh)"

# kubectl
source <(kubectl completion zsh)
compdef kubecolor=kubectl
compdef kc=kubecolor

# fzf bindings (for ^R fzf support for example)
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh

# setup prompt
eval "$(starship init zsh)"
source <(starship completions zsh)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
