#!/bin/bash

set +e

for script in $(dirname $0)/setup_{zsh,brew,mas,python,defaults,login}.sh; do
    source $script
done

echo "Installing oh-my-zsh..."
s_zsh

echo "Installing brew packages / casks..."
s_brew

echo "Installing Mac App Store Apps..."
s_mas

echo "Installing Python versions..."
s_python --latest

echo "Setting MacOS defaults..."
s_defaults

echo "Setting Apps to open at login..."
s_login

