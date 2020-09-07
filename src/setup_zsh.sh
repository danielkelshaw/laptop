#!/bin/bash


function install_omzsh() {
    
    if [[ ! -f $HOME/.oh-my-zsh ]]; then
        echo "Installing oh-my-zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
        echo "oh-my-zsh already installed..."
    fi 

}


function install_powerline_fonts() {
    
    local dirname=fonts

    echo "Installing Powerline Fonts"
    git clone git clone https://github.com/powerline/fonts.git --depth=1 $HOME/$dirname
    cd $HOME/$dirname
    ./install.sh
    cd $HOME
    rm -rf $HOME/$dirname

}


function overwrite_zshrc() {
    
    echo "Writing basic ~/.zshrc file..."
    echo "Remember that the ~/.zshrc file will need customising."

cat << 'EOF' > $HOME/.zshrc
## User Config #####################################
# ...insert config here

## ZSH Config #####################################
    
export ZSH="/Users/danielkelshaw/.oh-my-zsh"
ZSH_THEME="agnoster"
CASE_SENSITIVE="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh
EOF

}


function s_zsh() {

    install_omzsh
    install_powerline_fonts
    overwrite_zshrc

    source $HOME/.zshrc

cat << 'EOF'

    My prefered fonts to use with iTerm2 is "Source Code Pro + Font Awesome"
        Link can be found: https://gist.github.com/kevin-smets/8568070

    A basic ~/.zshrc has been written but this will still need to be customised...

EOF

}


if [[ $0 == $BASH_SOURCE ]]; then
    s_zshrc
fi

