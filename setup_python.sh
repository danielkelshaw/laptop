#!/bin/bash


pyversions=(
    3.6.8
    3.7.2
)


function setup_python() {
    
    if command -v pyenv &>/dev/null; then
        eval "$(pyenv init -)"
    elif command -v brew &>/dev/null; then 
        brew install pyenv
        eval "$(pyenv init -)"
    else
        echo "Please install Homebrew first..."
        exit 1
    fi

    if [[ $1 == "--latest" ]]; then
        pyversions+=($(pyenv install --list | grep -E "^[[:space:]]*[0-9]+\.[0-9]+\.[0-9]+$" | tail -1 | sed -E "s/[[:space:]]//g"))
    fi

    for vers in ${pyversions[@]}; do
        pyenv install -s $vers
    done

    pyenv global ${pyversions[${#pyversions[@]}-1]}

cat << 'EOF'

==================================================

    Remember to add the following to ~/.zshrc:

        if command -v pyenv &>/dev/null; then
            eval "$(pyenv init -)"
        fi

    This will not be done automatically.

==================================================

EOF

}


if [[ $0 == $BASH_SOURCE ]]; then
    setup_python $1
fi

