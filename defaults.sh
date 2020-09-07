#!/bin/bash

function set_defaults() {
    
    # Quit any System Preferences Panes
    osascript -e 'tell application "System Preferences" to quit'

    # Keep-alive: update existing `sudo` time stamp
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###### GENERAL UI / UX ############################################################

    # Disable the sound effects on boot
    sudo nvram SystemAudioVolume=" "

    # Expand save panel by default
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

    # Expand print panel by default
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

    # Automatically quit printer app once the print jobs complete
    defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

    # Disable the “Are you sure you want to open this application?” dialog
    defaults write com.apple.LaunchServices LSQuarantine -bool false

###### MOUSE / KEYBOARD ###########################################################

    # Use scroll gesture with the Ctrl (^) modifier key to zoom
    defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
    defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

    # Follow the keyboard focus while zoomed in
    defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

###### SCREEN #####################################################################

    # Save screenshots to the desktop
    defaults write com.apple.screencapture location -string "${HOME}/Desktop"

    # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
    defaults write com.apple.screencapture type -string "png"

    # Disable shadow in screenshots
    defaults write com.apple.screencapture disable-shadow -bool false

    # Enable subpixel font rendering on non-Apple LCDs
    # Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
    defaults write NSGlobalDomain AppleFontSmoothing -int 1

###### FINDER #####################################################################

    # Finder: show status bar
    defaults write com.apple.finder ShowStatusBar -bool true

    # Finder: show path bar
    defaults write com.apple.finder ShowPathbar -bool true

    # Display full POSIX path as Finder window title
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

    # Use list view in all Finder windows by default
    # Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
    defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

###### DOCK #######################################################################
    
    # Set the icon size of Dock items to 36 pixels
    defaults write com.apple.dock tilesize -int 36

    # Automatically hide and show the Dock
    defaults write com.apple.dock autohide -bool true

    # Restart Dock
    killall Dock

###################################################################################

    echo "Done. Note that some of these changes require a logout/restart to take effect."

}

if [[ $0 = $BASH_SOURCE ]]; then
    set_defaults
fi

