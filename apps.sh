#!/bin/bash

# >>>

source .env

# >>>

# Install XCode command-line tools
xcode-select --install

# Install Homebrew and Homebrew-Cask
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask

# Install command-line tools 
brew install \
    coreutils moreutils findutils psutils binutils `# Utility Packages` \
    nmap socat `# Networking` \
    screen tmux tmux-mem-cpu-load `# Terminal Sessions` \
    bash bash-completion2 `# Shell` \
    git grep openssh gnupg2 watch tree \
    gnu-sed --with-default-names \
    wget --with-iri \
    vim --with-override-system-vi \
    mas `# Mac App Store CLI`

# Install applications
brew cask install \
    1password \
    iterm2 \
    path-finder dropbox \
    google-chrome firefox \
    spectacle cleanmymac \
    vagrant virtualbox docker \
    skype spotify vlc \
    little-snitch \
    --appdir=/Applications

# Install applications from the Mac App Store
mas install \
    937984704 `# Amphetamine` \
    411643860 `# Daisy Disk` \
    407963104 `# Pixelmator` \
    634148309 `# Logic Pro X`

# Use brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
    echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
    chsh -s /usr/local/bin/bash;
fi

# Remove stock default applications from the Dock 
declare -a apps=(
    'Calendar' 'Contacts' 'Facetime' 
    'iBooks' 'iTunes' 'Keynote' 
    'Launchpad' 'Mail' 'Maps' 
    'Messages' 'Notes' 'Number' 'Pages' 
    'Photo' 'Reminders' 'Safari' 'Siri'
    'Terminal'
    )
for app in "${apps[@]}"
do
    dloc=$(defaults read com.apple.dock persistent-apps | grep _CFURLString\" | awk '/'"$app"'/ {print NR}')
    if [ ! -z "$dloc" ]; then
        /usr/libexec/PlistBuddy -c "Delete persistent-apps:$dloc" ~/Library/Preferences/com.apple.dock.plist
    fi
done

# Add custom default applications to Dock
declare -a apps=('iTerm' 'Path%20Finder' 'Google%20Chrome')
for app in "${apps[@]}"
do
    dloc=$(defaults read com.apple.dock persistent-apps | grep _CFURLString\" | awk '/'"$app"'/ {print NR}')
    if [ -z "$dloc" ]; then
        defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/'"$app"'.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
    fi
done

# Run application-specific scripts
for f in ./apps-*; do 
    source "$f"; 
done

# Restart Dock
killall Dock

