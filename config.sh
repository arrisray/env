#!/bin/bash

# >>>

source .env

# >>>

# Copy all dotfiles to the user's home directory
cp -a ./dotfiles/. $HOME

# Configure vim
mkdir -p $HOME/.vim/colors
mkdir -p $HOME/.vim/backups
mkdir -p $HOME/.vim/swaps
mkdir -p $HOME/.vim/undo
cp config/solarized.vim $HOME/.vim/colors 

# Set global git user
git config --global user.name $_GIT_USER_NAME
git config --global user.email $_GIT_USER_EMAIL

# Create Code directory
mkdir -p $HOME/Code
