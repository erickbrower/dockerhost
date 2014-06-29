
function _check_vagrant() {
    hash vagrant 2>/dev/null || { 
        echo >&2 "ERROR: Vagrant is not installed! Please install it before continuing." 
        echo >&2 "http://www.vagrantup.com"
        exit 1 
        }
}

function _check_virtualbox() {
    hash vboxmanage 2>/dev/null || { 
        echo >&2 "ERROR: Virtualbox is not installed! Please install it before continuing."
        echo >&2 "http://www.virtualbox.org"
        exit 1 
        }
}

function _check_docker_client() {
    hash docker 2>/dev/null || { 
        echo >&2 "ERROR: Docker is not installed! Please install it before continuing."
        echo >&2 "\`brew install docker\`"
        exit 1 
        }
}
function _set_exports() {
    echo "Setting exports for DOCKERHOST in $1"
    echo 'export DOCKER_HOST=tcp://localhost:2375' >> $1
    echo "export DOCKERHOST=$DOCKERHOST" >> $1
    . $1
}

_check_vagrant
_check_virtualbox
_check_docker_client

if [ ! -n "$DOCKERHOST" ]; then
    DOCKERHOST=~/.dockerhost
fi

if [ -d "$DOCKERHOST" ]; then
    echo "ERROR: dockerhost is already installed!"
    exit 1
fi

git clone https://github.com/erickbrower/dockerhost.git $DOCKERHOST
(cd $DOCKERHOST && vagrant up)


if [ -f ~/.bashrc ]; then
    _set_exports ~/.bashrc
elif [ -f ~/.zshrc ]; then
    _set_exports ~/.zshrc
fi

echo "GREAT SUCCESS! Try running a command like 'docker pull erickbrower/rails'"
