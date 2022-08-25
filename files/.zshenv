# session wide environment variables
#
# add user scripts to path
export PATH=~/.scripts:~/.go/bin:$PATH:~/.cargo/bin:~/.local/bin


# run firefox in wayland mode
export MOZ_ENABLE_WAYLAND=1

export EDITOR="nvim"
export VISUAL="nvim"

# theming 
#export GTK_THEME="Adwaita:dark"
#export QT_STYLE_OVERRIDE="Adwaita-dark"
#export QT_QPA_PLATFORM=wayland
#export QT_STYLE_OVERIDE="GTK+"
#export QT_QPA_PLATFORMTHEME="qt5ct"

# xdg configuration
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# set alacritty to be the i3 terminal
export TERMINAL='alacritty'
export TERM='xterm-256color'

# use bat as a pager for man, enabling syntax highlighting
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# set bat theme
export BAT_THEME="TwoDark"

