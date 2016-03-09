# Load the shell dotfiles, and then some:
# * ~/.extra can be used for other setting you don't want to commit
for file in ~/{.bash_prompt,.exports,.aliases,.functions,.extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Make git use `~/.gitignore` as global gitignore
git config --global core.excludesfile ~/.gitignore

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

if [[ "`uname`" == "Darwin" ]]; then
    if [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
    	source "$(brew --prefix)/share/bash-completion/bash_completion";
    elif [ -f /etc/bash_completion ]; then
    	source /etc/bash_completion;
    fi;

    source $(brew --prefix)/etc/profile.d/z.sh
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

    LUNCHY_DIR=$(dirname `gem which lunchy`)/../extras
    if [ -f $LUNCHY_DIR/lunchy-completion.bash ]; then
        . $LUNCHY_DIR/lunchy-completion.bash
    fi
fi
