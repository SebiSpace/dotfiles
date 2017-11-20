#!/usr/bin/env bash

BLUE="\e[1;34m%-6s\e[m\n"

printf "\n$BLUE" "Installing dotfiles"

# perform macOS-specific install
if [ "$(uname)" == "Darwin" ]; then
    printf "\n$BLUE" "Running on OSX"

    source install/mac.sh
fi

source install/link.sh

source install/git.sh

while true; do
    read -p "Install rust?" yn
    case $yn in
        [Yy]* ) printf "\n$BLUE" "Installing rust"; command -v rustup >/dev/null 2>&1 || { curl https://sh.rustup.rs -sSf > rustup.sh; chmod +x rustup.sh; ./rustup.sh -y; rm rustup.sh; }; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
