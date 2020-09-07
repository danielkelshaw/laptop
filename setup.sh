#!/bin/bash

set +e

for script in $(dirname $0)/setup_{brew,python,defaults,login}.sh; do
    source $script
done


apps=(
    # need to `brew install mas` / write script
    441258766 # magnet
    904280696 # things
)


if [[ ! -f $HOME/.oh-my-zsh ]]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "Installing brew packages / casks"
s_brew

echo "Installing Python versions..."
s_python --latest

echo "Setting MacOS defaults..."
s_defaults

echo "Setting Apps to open at login..."
s_login

