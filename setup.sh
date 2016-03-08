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

    printf "\n$BLUE" "Installing brew tools and cask apps"

    brew bundle

    # Making bash 4 default shell
    printf "\n$BLUE" "Changing shell to bash for user $USER"

    grep -q '/usr/local/bin/bash' /etc/shells || echo '/usr/local/bin/bash' | sudo tee -a /etc/shells
    chsh -s /usr/local/bin/bash

    # Installing RVM, ruby 2.2 and gems
    if [ ! -f $HOME/.rvm/scripts/rvm ]; then
      printf "\n$BLUE" "Installing RVM"
      gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
      curl -L get.rvm.io | bash -s stable
    else
      printf "\n$BLUE" "RVM already installed"
    fi

    # Sourcing script to use rvm
    source $HOME/.rvm/scripts/rvm

    # Installing Ruby 2.2
    printf "\n$BLUE" "Installing Ruby 2.2"

    rvm install 2.2

    # Installing Ruby gems
    printf "\n$BLUE" "Installing Ruby gems"

    gems=("sass" "iStats")
    for gem in "${gems[@]}"; do
      if [[ $(gem list | grep "$gem") ]]; then
        echo "$gem already installed"
      else
        gem install "$gem"
      fi
    done

    # App Store Applications installation
    printf "\n$BLUE" "Installing Mac App Store applications"

    apps=("497799835" "409183694" "890031187" "409201541" "557168941" "937984704" "409203825")

    for app in "${apps[@]}"; do
        if [[ $(mas list | grep "$app") ]]; then
		    echo "App $app already installed"
    	else
    		mas install "$app"
    	fi
    done

    # installing node modules
    printf "\n$BLUE" "Installing global node modules"

    modules=("bower" "babel-cli" "nodemon" "yo" "gulp" "jade" "express-generator")

    for module in "${modules[@]}"; do
      if [[ $(npm list -g | grep "$module") ]]; then
        echo "Module $module already installed"
      else
        npm install -g "$module"
      fi
    done

    printf "\n$BLUE" "Copying dotfiles"

    # Copy dotfiles to home directory
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1 -r;
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
    	rsync --exclude ".git/" --exclude "apps.md"  --exclude ".DS_Store" --exclude "setup.sh" --exclude "README.md" --exclude "Brewfile" --exclude ".osx" --exclude "Gruvbox.itermcolors" -avh --no-perms . ~;
    fi
else
    # Copy dotfiles to home directory
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1 -r;
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rsync --exclude ".git/" --exclude "apps.md" --exclude ".DS_Store" --exclude "setup.sh" --exclude "Brewfile" --exclude "README.md" --exclude ".hushlogin" --exclude ".tmux-osx.conf" --exclude ".osx" --exclude "Gruvbox.itermcolors" -avh --no-perms . ~;
    fi
fi

printf "\n$BLUE" "Please run 'source ~/.bash_profile'"
