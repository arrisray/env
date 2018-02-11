#!/bin/bash

# >>>

source .env

# >>>

# Configure installed applications
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# Install the Solarized Dark theme for iTerm
open "config/Solarized_Dark.itermcolors"
