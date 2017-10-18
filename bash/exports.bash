# Make nano the default editor
export EDITOR="vim"
export GIT_EDITOR="vim"

# Prefer US English and use UTF-8
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"


# Add ~/bin to Path for custom code
export PATH="$HOME/bin:$PATH"
# Add /usr/local/sbin for brew
export PATH="/usr/local/sbin:$PATH"
# Add ~/.yarn/bin for yarn globals
export PATH="$HOME/.yarn/bin:$PATH"
# Add rustup
export PATH="$HOME/.cargo/bin:$PATH"

# Homebrew Cask installation path
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
