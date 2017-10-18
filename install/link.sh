#!/usr/bin/env bash

BLUE="\e[1;34m%-6s\e[m\n"

DOTFILES=$HOME/.dotfiles

printf "\n$BLUE" "Creating symlinks"]

linkables=$( find -H "$DOTFILES" -name '*.symlink' )

for file in $linkables ; do
    target="$HOME/.$( basename $file '.symlink' )"
    if [ -e $target ]; then
        echo "~${target#$HOME} already exists... Skipping."
    else
        echo "Symlinking $file to $target"
        ln -s $file $target
    fi
done

printf "\n$BLUE" "Installing to ~/.config"

if [ ! -d $HOME/.config ]; then
    echo "Creating ~/.config"
    mkdir -p $HOME/.config
fi

for config in $DOTFILES/config/*; do
    target=$HOME/.config/$( basename $config )
    if [ -e $target ]; then
        echo "~${target#$HOME} already exists... Skipping."
    else
        echo "Symlinking $config to $target"
        ln -s $config $target
    fi
done
