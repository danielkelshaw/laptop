#!/bin/bash


casks=(
    1password
    docker
    github
    google-chrome
    iterm2
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


function get_brew() {

    if ! command -v brew &>/dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" </dev/null
    else
        echo "Updating Homebrew..."
        brew update
        brew upgrade
        brew doctor
    fi

}


function install_or_upgrade() {

    if ! command -v brew &>/dev/null; then
        echo "Must install Homebrew first..."
        exit 1
    fi

    if brew ls --versions $1 &>/dev/null; then
        echo "-> Upgrading $1"
        HOMEBREW_NO_AUTO_UPDATE=1 brew upgrade $1
    else
        echo "-> Installing $1"
        HOMEBREW_NO_AUTO_UPDATE=1 brew install $1
    fi

}

function cask_install_or_upgrade() {

    if ! command -v brew &>/dev/null; then
        echo "Must install Homebrew first..."
        exit 1
    fi

    if brew cask ls --versions $1 &>/dev/null; then
        echo "-> Installing $1"
        HOMEBREW_NO_AUTO_UPDATE=1 brew cask upgrade $1
    else
        echo "-> Installing $1"
        HOMEBREW_NO_AUTO_UPDATE=1 brew cask install $1
    fi

}


function s_brew() {
    
    get_brew
    
    echo "Installing brew packages..."
    for pbrew in ${brews[@]}; do
        install_or_upgrade $pbrew
    done

    echo "Installing brew casks..."
    for cask in ${casks[@]}; do
        cask_install_or_upgrade $cask
    done

    echo "Cleaning up brew..."
    brew cleanup

}


if [[ $0 == $BASH_SOURCE ]];then
    s_brew
fi

