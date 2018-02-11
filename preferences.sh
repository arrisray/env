#!/bin/bash

# SYSTEM
# NETWORK
# PRINTER
# KEYBOARD
# TRACKPAD
# DISPLAY
# FINDER
# DOCK
# DESKTOP
# UTILITIES

# >>>

source .env

# Close any open System Preferences panes, 
# to prevent them from overriding settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# >>>

# SYSTEM

# Disable Gatekeeper application open prompts
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Restart when frozen/hung 
sudo systemsetup -setrestartfreeze on

# Disable various auto-correct features that don't apply to code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Set the timezone
# See `sudo systemsetup -listtimezones` for other values
sudo systemsetup -settimezone "America/New_York" > /dev/null

# Disable fast user switching
# sudo defaults write /Library/Preferences/.GlobalPreferences MultipleSessionEnabled -bool false

# Disable ambient light sensor 
# sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Display Enabled" -bool false

# Turn off SSD sudden motion sensor, set stand-by delay to 1 day
# sudo pmset -a sms 0
# sudo pmset -a standbydelay 86400

# NETWORK

# Set computer hostname
sudo scutil --set ComputerName "$_HOSTNAME"
sudo scutil --set HostName "$_HOSTNAME"
sudo scutil --set LocalHostName "$_HOSTNAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$_HOSTNAME"

# PRINTER

# Quit printer app immediately after all jobs complete
defaults write com.apple.print.PrintingPrefs “Quit When Finished” -bool true

# KEYBOARD

# Enable Full Keyboard Access
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Default to a very fast key repeat rate with a small delay 
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 12

# Allow press and hold keys
sudo defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# TRACKPAD

# Map right-click to bottom-right corner
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# Enable natural scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

# Enable tap-to-click
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Scroll with Ctrl to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

# Follow keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

# DISPLAY

# Show percentage
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
defaults write com.apple.menuextra.battery ShowTime -string "NO"

# Require password immediately after sleep or screen saver begins 
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Enable HiDPI display modes
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

# FINDER

# Show hidden files by default 
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show filename extensions 
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Sort folders first when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Immediately spring load directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Allow text selection in QuickLook
defaults write com.apple.finder QLEnableTextSelection -bool true

# Display full POSIX path as window title 
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Disable warning when changing file extension 
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Disable creation of .ds_store files on network volumes or USB drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Default to list view 
# Options: Nlsv, Icnv, Clmv, Flwv
defaults write com.apple.finder FXPreferredViewStyle -string “Nlsv”

# Disable empty trash warning
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Default to securely emptying trash 
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Default to showing the User Library 
chflags nohidden ~/Library

# Default to showing the Volumes folder
sudo chflags nohidden /Volumes

# Default search to the current folder 
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable all animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Set sane screen capture defaults 
defaults write com.apple.screencapture location -string "$HOME/Desktop"
defaults write com.apple.screencapture type -string "png"

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Default to show icons for: hard drives, servers and removable media 
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Default to $HOME
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Show item info near icons on the desktop and in other icon views
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Increase grid spacing for icons on the desktop and in other icon views
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

# Increase the size of icons on the desktop and in other icon views
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist


# DOCK

# Disable animating icons when opening applications
defaults write com.apple.dock launchanim -bool false

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Disable auto-hide delay 
# defaults write com.apple.Dock autohide-delay -float 0

# Disable animation when showing/hidning the dock 
defaults write com.apple.dock autohide-time-modifier -float 0

# Default auto-hiding the dock 
# defaults write com.apple.dock autohide -bool true

# Speed up Expose animation and group by app 
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

# Setup hot corners
# 0: no-op
# 2: Mission Control
# 3: Show application windows
# 4: Desktop
# 5: Start screen saver
# 6: Disable screen saver
# 7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# Mission Control: Top Left 
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0
# Desktop: Top Right 
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0
# Screen Saver: Bottom Left 
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# UTILITIES

# Default sort activity by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# Enable the debug menu 
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable local Time Machine backups
hash tmutil &> /dev/null && sudo tmutil disablelocal

# APPS

# Set default Terminal theme
# Options: "Pro", "Homebrew", "Man Page", "Novel", "Ocean", "Red Sands", "Silver Aerogel", "Solid Colors"
# defaults write com.apple.terminal StringEncodings -array 4
# defaults write com.apple.terminal "Default Window Settings" -string "Homebrew"
# defaults write com.apple.terminal "Startup Window Settings" -string "Homebrew"

# Disable Terminal's prompt-on-quit
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# Turn off Smart Quotes in text messages since they interfere with code snippets 
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

# Disable Dashboard by default
defaults write com.apple.dashboard mcx-disabled -boolean YES

# Default to use plain text mode for new documents in TextEdit
defaults write com.apple.TextEdit RichText -int 0

# Default to opening and saving files as UTF–8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

