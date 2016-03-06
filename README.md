# dotfiles

### Installing

First you have to run the setup script which will install the command line tools, homebrew, all brew tools and cask applications, global node modules, rvm, ruby 2.2, some gems and some app store applications

```bash
chmod +x setup.sh .osx
./setup

# if wanted, osx defaults can be set by running
./.osx
```

Create `.extra` file in your home directory
Example content:

```bash
GIT_AUTHOR_NAME="YOUR NAME"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"

GIT_AUTHOR_EMAIL="YOUR EMAIL ADDRESS"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"

git config --global credential.helper osxkeychain
```

Some apps can't be installed automatically so you have to install the manually. These applications are listed in `apps.md`
