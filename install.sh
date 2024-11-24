#!/bin/bash

set -e

echo "Cloning dotfiles repository..."
git clone git@github.com:orielsanchez/.dotfiles.git ~/.dotfiles

echo "Creating symlinks..."
ln -sf ~/.dotfiles/zshrc ~/.zshrc
ln -sf ~/.dotfiles/zprofile ~/.zprofile
ln -sf ~/.dotfiles/Brewfile ~/Brewfile
ln -sf ~/.dotfiles/config/nvim ~/.config/nvim
ln -sf ~/.dotfiles/config/kitty ~/.config/kitty
ln -s ~/.dotfiles/bin/ ~/.local/bin

echo "Installing dependencies with Homebrew..."
if command -v brew &> /dev/null; then
  brew bundle --file=~/dotfiles/Brewfile
else
  echo "Homebrew not found. Skipping dependency installation."
fi

echo "Dotfiles installation complete!"
