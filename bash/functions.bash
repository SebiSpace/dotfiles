# print available colors and their numbers
function colors() {
    for i in {0..255}; do
        printf "\x1b[38;5;${i}m colour${i}"
        if (( $i % 5 == 0 )); then
            printf "\n"
        else
            printf "\t"
        fi
    done
}

# Change working directory to the top-most Finder window location
cdf() { # short for `cdfinder`
    cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
}

update() {
    case "`uname`" in
    Darwin )
        printf "$BLUE" "Updating system"
        sudo softwareupdate -i -a || exit

        printf "\n$BLUE" "Updating Mac App Store Applications"
        mas upgrade

        printf "\n$BLUE" "Updating brew"
        brew update
        brew upgrade
        brew cleanup --force --prune=0 -s
        brew cask cleanup
        brew prune

        printf "\n$BLUE" "Updating npm"
        yarn global upgrade

        printf "\n$BLUE" "Updating rust"
        rustup update

        ;;
    Linux )
        printf $BLUE "Updating system"

        sudo apt-get update
        sudo apt-get upgrade

        ;;
    esac
}

quitall() {
    kill $(osascript -e 'tell app "System Events" to unix id of processes where background only is false'|tr -d ,)
}
