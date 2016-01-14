#!/usr/bin/env bash

BLUE="\e[1;34m%-6s\e[m\n"

if [[ "`uname`" == "Darwin" ]]; then
    APPS=( "http://www.macbartender.com/" "http://www.sublimetext.com/3" "https://www.wireshark.org/download.html" "https://filezilla-project.org/download.php?type=client" )

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
    echo "/usr/local/bin/bash" >> /etc/shells
    chsh -s /usr/local/bin/bash

    # Manual app installation
    printf $BLUE "Download and install following applications (⌘ + Double Click)"

    for app in "${APPS[@]}"
    do
    	echo $app
    done

    read -p "Press Enter when you are done"


    printf $BLUE "Copying dotfiles"

    # Copy dotfiles to home directory
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1 -r;
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
    	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "setup.sh" --exclude "brew.sh" --exclude "README.md" -avh --no-perms . ~;
    fi
else
    # Copy dotfiles to home directory
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1 -r;
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rsync --exclude ".git/" --exclude ".DS_Store" --exclude "setup.sh" --exclude "brew.sh" --exclude "README.md" --exclude ".hushlogin" -avh --no-perms . ~;
    fi
fi
printf $BLUE "Please run 'source ~/.bash_profile'"
