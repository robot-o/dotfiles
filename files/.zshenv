# session wide environment variables
# zsh specific
#
function include() {
  [[ -f "$1" ]] && source "$1"
}

include "$HOME/.shell_env"
