#!/bin/bash

if [ ! -n "$DOCKERHOST" ]; then
    DOCKERHOST=~/.dockerhost
fi

[ -d ~/Workbench ] || mkdir -p ~/Workbench

function check_installed() {
    if [ -d "$DOCKERHOST" ]; then
        echo "ERROR: dockerhost is already installed!"
        echo "Uninstall it with \`curl -L https://raw.github.com/erickbrower/dockerhost/master/uninstall.sh | sh\`"
        exit 1
    fi
}

function check_prereq() {
        hash $1 2>/dev/null || { 
        echo >&2 "ERROR: $1 is not installed! Please install it before continuing." 
        echo >&2 $2
        exit 1 
        }
}

function check_prerequisites() {
    _check_prereq vagrant "http://www.vagrantup.com"
    _check_prereq vboxmanage "http://virtualbox.org"
    _check_prereq docker "\`brew install docker\`"

}

function install() {
    git clone https://github.com/erickbrower/dockerhost.git $DOCKERHOST
    (cd $DOCKERHOST && vagrant up)
    cp $DOCKERHOST/dh /usr/local/bin/dh
    chmod +x /usr/local/bin/dh
}

function set_exports() {
    echo "Setting exports for DOCKERHOST in $1"
    echo 'export DOCKER_HOST=tcp://localhost:2375' >> $1
    echo "export DOCKERHOST=$DOCKERHOST" >> $1
    . $1
}

check_installed
check_prerequisites
install

if [ -f ~/.bashrc ]; then
    set_exports ~/.bashrc
elif [ -f ~/.zshrc ]; then
    set_exports ~/.zshrc
fi

echo "GREAT SUCCESS! Try running a command like 'docker pull erickbrower/rails'"
