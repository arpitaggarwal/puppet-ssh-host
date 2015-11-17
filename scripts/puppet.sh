#!/bin/bash

function do_main() {
    install_puppet
}

function install_puppet() {
    if [ "$(gem search -i puppet)" = "false" -o $(puppet --version) != "3.4.3" ]; then
        install_gem_package puppet 3.4.3
    else
        echo 'puppet found'
    fi
}

function install_gem_package {
    echo "installing $1 $2"
    $(which gem > /dev/null 2>&1)
    FOUND_GEM=$?

    if [ "${FOUND_GEM}" -eq '0' ]; then
        if [ -z "$2" ]; then
            gem install $1
        else
            gem install $1 -v $2
        fi
        echo "$1 $2 installed."
    else
        failed "No gem package installer available. You may need to install $1 $2 manually."
    fi
}

do_main
