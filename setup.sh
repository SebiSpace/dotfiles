#!/usr/bin/env bash

BLUE="\e[1;34m%-6s\e[m\n"

if [[ "`uname`" == "Darwin" ]]; then
    sudo -v
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

    # Installing command line tools
    xcode-select --install
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

    # Make directory for go
    mkdir ~/.go

    # Install rust
    command -v rustup >/dev/null 2>&1 || { curl https://sh.rustup.rs -sSf > rustup.sh; chmod +x rustup.sh; ./rustup.sh -y; rm rustup.sh; }

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

    gems=("sass" "iStats" "lunchy")
    for gem in "${gems[@]}"; do
      if [[ $(gem list | grep "$gem") ]]; then
        echo "$gem already installed"
      else
        gem install "$gem"
      fi
    done

    # installing node modules
    printf "\n$BLUE" "Installing global node modules"

    modules=("bower" "babel-cli" "nodemon" "yo" "gulp-cli" "pug" "generator-express" "fkill-cli" "generator-webapp")

    installed="`npm list -g`"

    for module in "${modules[@]}"; do
      if [[ $(echo "$installed" | grep "$module") ]]; then
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
    	rsync --exclude ".git/" --exclude "apps.md"  --exclude ".DS_Store" --exclude "setup.sh" --exclude "README.md" --exclude "Brewfile" --exclude ".osx" --exclude "iterm2/" -avh --no-perms . ~;
    fi
else
    # Copy dotfiles to home directory
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1 -r;
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rsync --exclude ".git/" --exclude "apps.md" --exclude ".DS_Store" --exclude "setup.sh" --exclude "Brewfile" --exclude "README.md" --exclude ".hushlogin" --exclude ".osx" --exclude "iterm2/" --exclude ".editorconfig" -avh --no-perms . ~;
    fi
fi

printf "\n$BLUE" "Please run 'source ~/.bash_profile'"
