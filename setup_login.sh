#!/bin/bash


apps=(
    iTerm
    Magnet
    Docker
)


function login_items() {

    osascript -e 'tell application "System Preferences" to quit'
    items=$(osascript -e 'tell application "System Events" to get the name of every login item')

    for app in ${apps[@]}; do
        if [[ $items != /Applications/$app ]] && [[ -d /Applications/$app.app ]]; then
            osascript -e 'tell application "System Events" to make login item at end with properties {name: "$app", path: "/Applications/iTerm.app", hidden: false}' &>/dev/null;
            echo "Added $app to login items."
        fi
    done

}


if [[ $0 == $BASH_SOURCE ]]; then
    login_items
fi

