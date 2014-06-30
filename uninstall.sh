#!/bin/bash

if [ ! -n "$DOCKERHOST" ]; then
    DOCKERHOST=~/.dockerhost
fi

function check_installed() {
    if [ ! -d "$DOCKERHOST" ]; then
        echo "ERROR: dockerhost is not installed!"
        echo "Install it with \`curl -L https://raw.github.com/erickbrower/dockerhost/master/install.sh | sh\`"
        exit 1
    fi
}

function uninstall() {
    (cd $DOCKERHOST && vagrant destroy -f)
    echo "Removing $DOCKERHOST directory..."
    rm -rf $DOCKERHOST
}

echo "SUCCESS! dockerhost has been uninstalled. Bye!"
