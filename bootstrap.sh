#!/bin/bash

# >>>

source .env

# >>>

# Run target scripts
source preferences.sh
source apps.sh
source config.sh

# Perform a system update
killall Dock
sudo softwareupdate --install -all
