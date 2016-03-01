#!/usr/bin/env bash

BLUE="\e[1;34m%-6s\e[m\n"

if [[ "`uname`" == "Darwin" ]]; then
    sudo -v
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

    # Installing command line tools
    xcode-select --install
    read -p "Press Enter when either the command line tools or Xcode are installed"

    # Making shure that the command line tools or Xcode are installed
    command -v clang >/dev/null 2>&1 || { echo "Command line tools aren't installed"; exit 1; }

    # Installing brew if not
    command -v brew >/dev/null 2>&1 || { ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"; }

    printf $BLUE "Installing brew tools and cask apps"

    brew tap homebrew/bundle
    brew bundle

    # Making Google Chrome default browser
    open -a "Google Chrome" --args --make-default-browser

    # Making bash 4 default shell
    echo "/usr/local/bin/bash" | sudo tee -a /etc/shells
    chsh -s /usr/local/bin/bash

    # Installing RVM
    curl -L get.rvm.io | bash -s stable

    # App Store Applications installation

    apps = ("497799835" "948415170" "409183694" "890031187" "409201541" "557168941" "937984704" "409203825")

    for app in "${apps[@]}"; do
        if [[ $(mas list | grep "$app") ]]; then
		    echo "App $app already installed."
    	else
    		mas install "$app"
    	fi
    done

    printf $BLUE "Copying dotfiles"

    # Copy dotfiles to home directory
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1 -r;
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
    	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "setup.sh" --exclude "README.md" --exclude "Brewfile" -avh --no-perms . ~;
    fi
else
    # Copy dotfiles to home directory
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1 -r;
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rsync --exclude ".git/" --exclude ".DS_Store" --exclude "setup.sh" --exclude "Brewfile" --exclude "README.md" --exclude ".hushlogin" --exclude ".tmux-osx.conf" -avh --no-perms . ~;
    fi
fi
printf $BLUE "Please run 'source ~/.bash_profile'"
