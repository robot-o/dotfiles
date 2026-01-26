#!/usr/bin/env bash
set -v -o pipefail

echo "ensuring $HOME/.config exists.."
[[ -d "$HOME/.config" ]] && mkdir "$HOME/.config" 

echo "symlinking dotfiles.."
ln -sf ~/.dotfiles/files/.shell_env ~/.shell_env
ln -sf ~/.dotfiles/files/.bash_profile ~/.bash_profile
ln -sf ~/.dotfiles/files/.bash_env ~/.bash_env
ln -sf ~/.dotfiles/files/.bashrc ~/.bashrc
ln -sf ~/.dotfiles/files/.zshenv ~/.zshenv
ln -sf ~/.dotfiles/files/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/files/.aliases ~/.aliases
ln -sf ~/.dotfiles/files/.tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/files/.vimrc ~/.vimrc
ln -sf ~/.dotfiles/files/.config/nvim ~/.config/nvim
ln -sf ~/.dotfiles/files/.config/starship.toml ~/.config/starship.toml
ln -sf ~/.dotfiles/files/.config/tmuxp ~/.config/tmuxp
ln -sf ~/.dotfiles/files/.config/alacritty ~/.config/alacritty
ln -sf ~/.dotfiles/files/.scripts ~/.scripts
ln -sf ~/.dotfiles/files/.gitconfig ~/.gitconfig
