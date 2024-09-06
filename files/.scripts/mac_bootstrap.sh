#!/usr/bin/env bash
# vim: ft=sh
set -e -u -o pipefail

fix-defaults-dock(){
  echo -e 'fixing the dock..\n'
  defaults write com.apple.dock tilesize -int 32 &&
    #defaults write com.apple.dock orientation -string "left" &&
    defaults write com.apple.dock autohide -bool "true" &&
    defaults write com.apple.dock autohide-delay -float 0 &&
    defaults write com.apple.dock autohide-time-modifier -int 0 &&
    defaults write com.apple.dock showhidden -bool TRUE && 
    defaults write com.apple.dock show-recents -bool "false" && 
    defaults write com.apple.dock mineffect -string "scale" && 
    killall Dock
  echo -e '\n..done.' 
}

fix-defaults-finder() {
  echo -e '\n\nfixing the finder..\n' 
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
  echo -e '\n..done.' 
}

fix-defaults-misc() {
  echo -e '\n\nfixing misc..\n'
  defaults write com.apple.screencapture type -string "jpg"
  defaults write com.apple.safari ShowFullURLInSmartSearchField -bool "true" && killall Safari
  defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool "true"
  defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool "false" # key repeat 
  defaults write com.apple.TextEdit NSShowAppCentricOpenPanelInsteadOfUntitledFile -bool false
  defaults write -g NSWindowShouldDragOnGesture -bool false
  echo -e '\n..done.' 
}

fix-defaults() {
  fix-defaults-dock 
  fix-defaults-finder 
  fix-defaults-misc 
  echo -e '\n\n\nmacOS defaults done. \nmore info about default commands on macos-defaults.com\n\n\n'
}

install-brew() {
  echo -e '\ninstalling homebrew\n'
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 
}

install-apps(){
  echo -e '\ninstalling the good 💩\n'
  cd ~/.dotfiles && brew bundle install 
}

all() {
  fix-defaults &&
  install-brew &&
  install-apps 
}

command="${1}"
shift
${command} "$@"

echo -e '\n\n\nthink differently 🍎'

