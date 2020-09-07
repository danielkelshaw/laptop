#!/bin/bash


apps=(
    441258766 # magnet
    904280696 # things
)


function s_mas() {

    echo "Installing apps from Mac App Store..."
    
    if ! command -v mas &>/dev/null; then
        if command -v brew &>/dev/null; then
            brew install mas
        else
            echo "Please install Homebrew first..."
            exit 1
        fi
    fi

    for app in ${apps[@]}; do
        if mas search $app &>/dev/null; then
            echo "Installing $app..."
            mas install $app
        else
            echo "$app not found..."
        fi
    done

}


if [[ $0 == $BASH_SOURCE ]]; then
    s_mas
fi

