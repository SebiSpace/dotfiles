#!/usr/bin/env bash

BLUE="\e[1;34m%-6s\e[m\n"

printf "\n$BLUE" "Installing command line tools"
xcode-select --install

Making shure that the command line tools or Xcode are installed
command -v clang >/dev/null 2>&1 || { echo "Command line tools aren't installed"; exit 1; }

printf "\n$BLUE" "Installing homebrew"
command -v brew >/dev/null 2>&1 || { ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"; }

brew bundle

# Making bash 4 default shell
printf "\n$BLUE" "Changing shell to bash for user $USER"
grep -q '/usr/local/bin/bash' /etc/shells || echo '/usr/local/bin/bash' | sudo tee -a /etc/shells
chsh -s /usr/local/bin/bash $USER

# Unhide library
chflags nohidden ~/Library/

# Don't write .DS_Store files to network drives and external storage media
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Show extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
defaults write com.apple.ImageCapture disableHotPlug -bool true

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Save screenshots in PNG format
defaults write com.apple.screencapture type -string "png"

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Show battery percent in Menubar
defaults write com.apple.menuextra.battery ShowPercent -bool true

# Enable right click and tap with two fingers
defaults -currentHost write -g com.apple.trackpad.enableSecondaryClick -bool YES

# Crash reports as notifications
defaults write com.apple.CrashReporter UseUNC 1

# Disable MissionControl
defaults write com.apple.dashboard mcx-disabled -boolean true

# Use plain text in TextEdit
defaults write com.apple.TextEdit RichText -int 0

# Finder
defaults write com.apple.finder ShowPathbar -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Safari
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Time Machine
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -integer 50

# Disable Time Machine
sudo tmutil disable

# iTerm
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$HOME/.dotfiles/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -int 1

# Hide Desktop Icons
defaults write com.apple.finder CreateDesktop -bool false

# Change location of screenshots
defaults write com.apple.screencapture location ~/Dropbox/screenshots/

# Spotlight
defaults write com.apple.Spotlight showedLearnMore -int 1
