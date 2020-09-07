#!/bin/bash

set +e

for script in $(dirname $0)/{pysetup,defaults}.sh; do
    source $script
done

casks=(
    1password
    docker
    github
    google-chrome
    julia
    paraview
    pycharm
    slack
    sublime-text
    visual-studio-code
)

brews=(
    awscli
    cmake
    fzf
    git
    go
    htop
    imagemagick
    mas
    pyenv
    pyenv-virtualenv
    tmux
    vim
    watch
    wget
)


apps=(
    441258766 # magnet
)


# Deal with Homebrew
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" </dev/null
else
    echo "Updating Homebrew..."
    brew update
    brew upgrade
    brew doctor
fi

echo "Installing brew casks..."
for cask in ${casks[@]}; do
    if brew cask install $cask; then
        echo "-> Installed $cask"
    else
        echo "-> Failed to install $cask"
    fi
done

echo "Installing brew packages..."
for pbrew in ${brews[@]}; do
    if brew install $pbrew; then
        echo "-> Installed $pbrew"
    else
        echo "-> Failed to install $pbrew"
    fi
done

echo "Installing Python versions..."
setup_python --latest

echo "Setting MacOS defaults..."
set_defaults

