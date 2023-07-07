# vim: ft=sh
echo 'fixing the bad 🍎'
defaults write com.apple.dock autohide-delay -float 0 &&
defaults write com.apple.dock autohide-time-modifier -int 0 &&
defaults write com.apple.Dock showhidden -bool TRUE && 
killall Dock

echo 'installing the good 💩'
brew install \
    easy-move-plus-resize \
    spotify \
    obsidian \
    discord \
    btop \
    alt-tab \
    rectangle \
    alacritty \
    discord \
    firefox \
    obsidian \
    spotify \
    firefox \
    neovim \
    fzf \
    ripgrep \
    exa \
    fd \
    bat \
    tmux \
    btop \
    git-delta \
    starship \

echo 'think differently 🍎'

