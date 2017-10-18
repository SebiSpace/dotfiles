#!/usr/bin/env bash

BLUE="\e[1;34m%-6s\e[m\n"

printf "\n$BLUE" "Installing dotfiles"

# perform macOS-specific install
if [ "$(uname)" == "Darwin" ]; then
    printf "\n$BLUE" "Running on OSX"

    source install/osx.sh
fi

source install/link.sh

source install/git.sh

printf "\n$BLUE" "Installing rust"
# Install rust
command -v rustup >/dev/null 2>&1 || { curl https://sh.rustup.rs -sSf > rustup.sh; chmod +x rustup.sh; ./rustup.sh -y; rm rustup.sh; }
