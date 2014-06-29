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

if [ -f "~/.bashrc" ]; then
    echo 'export DOCKER_HOST=tcp://localhost:2375' >> ~/.bashrc
    . ~/.bashrc
fi

if [ -f "~/.zshrc" ]; then
    echo 'export DOCKER_HOST=tcp://localhost:2375' >> ~/.zshrc
    . ~/.zshrc
fi

echo "Done! Try running a command like 'docker pull erickbrower/rails'"
