# vim: ft=sh
set -euo pipefail


echo -e 'fixing the bad 🍎\n\n'

echo -e 'fixing the dock\n'
defaults write com.apple.dock tilesize -int 32 &&
defaults write com.apple.dock orientation -string "left" &&
defaults write com.apple.dock autohide -bool "true" &&
defaults write com.apple.dock autohide-delay -float 0 &&
defaults write com.apple.dock autohide-time-modifier -int 0 &&
defaults write com.apple.dock showhidden -bool TRUE && 
defaults write com.apple.dock show-recents -bool "false" && 
defaults write com.apple.dock mineffect -string "scale" && 
defaults write com.apple.dock && 
killall Dock

echo -e '\n\nfixing the finder\n' 
defaults write com.apple.finder QuitMenuItem -bool "true" && 
defaults write NSGlobalDomain AppleShowAllExtensions -bool "true" &&
defaults write com.apple.finder ShowPathbar -bool "true" &&
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true" &&
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf" && # current folder
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool "false" &&
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool "false" &&
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool "false" &&
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool "false" &&
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool "false" &&
killall Finder

echo -e '\n\nfixing misc\n'
defaults write com.apple.screencapture type -string "jpg"
defaults write com.apple.safari ShowFullURLInSmartSearchField -bool "true" && killall Safari
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool "true"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool "false" # key repeat 

echo -e '\n\n\nmacOS defaults done. \nmore info about default commands on macos-defaults.com\n\n\n'


echo -e '\ninstalling the good 💩\n'

echo -e '\ninstalling homebrew\n'
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &&

echo -e '\nbrew install\n'
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

echo -e '\n\n\nthink differently 🍎'

