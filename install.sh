
if [ ! -n "$DOCKERHOST" ]; then
    DOCKERHOST=~/.dockerhost
fi

if [ -d "$DOCKERHOST" ]; then
    echo "You already have a dockerhost installed! You'll need to remove $DOCKERHOST if you want to install"
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
