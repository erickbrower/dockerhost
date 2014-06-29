hash git >/dev/null 2>&1 && /usr/bin/env docker ps || {
  echo "ERROR: The docker client is not installed! Install it with \`brew install docker\`"
  exit
}

if [ ! -n "$DOCKERHOST" ]; then
    DOCKERHOST=~/.dockerhost
fi

if [ -d "$DOCKERHOST" ]; then
    echo "ERROR: dockerhost is already installed!"
    exit
fi

git clone https://github.com/erickbrower/dockerhost.git $DOCKERHOST
(cd $DOCKERHOST && vagrant up)

function _set_exports() {
    echo 'export DOCKER_HOST=tcp://localhost:2375' >> $1
    echo 'export DOCKERHOST=~/.dockerhost' >> $1
    . $1
}

if [ -f "~/.bashrc" ]; then
    _set_exports ~/.bashrc
fi

if [ -f "~/.zshrc" ]; then
    _set_exports ~/.zshrc
fi

echo "Done! Try running a command like 'docker pull erickbrower/rails'"
