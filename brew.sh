#!/usr/bin/env bash

# Installing brew tools

# Ask for the admin password upfront
sudo -v

# Keep alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure we're using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

# Install GNU core utils
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`
brew install gnu-sed --with-default-names
# Install Bash 4
# Note: don't forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`
brew install bash
brew tap homebrew/versions
brew install bash-completion2

# Install `wget` with IRI support
brew install wget --with-iri

# Install python2 and python3
brew install python
brew install python3

# Install other useful binaries
brew install brew-cask
brew install ffmpeg
brew install git
brew install htop-osx
brew install nmap
brew install node
brew install sqlite
brew install ssh-copy-id
brew install tree
brew install youtube-dl
brew install z
brew install pass

# Install cask binaries
brew tap caskroom/versions
brew cask install dropbox
brew cask install google-chrome
brew cask install iterm2-beta
brew cask install qlcolorcode
brew cask install qlmarkdown
brew cask install qlstephen
brew cask install quicklook-json

# Remove outdated versions from the cellar.
brew cleanup
