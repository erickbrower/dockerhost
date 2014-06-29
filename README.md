## dockerhost

A simple CoreOS instance as your Docker server on Mac OS X. 

### Install

1. `git clone git@github.com:erickbrower/dockerhost.git`
2. `cd dockerhost`
3. `vagrant up` (This will prompt you for your OS X admin password after a few seconds)
4. `echo 'export DOCKER_HOST=tcp://localhost:2375' >> ~/.bashrc` (or zshrc, if you use zsh)
5. `source ~/.bashrc`

### Install the Docker client

The simplest way is  `brew install docker`. Then check that your server is installed correctly by running `docker pull erickbrower/rails`


### Using 

The docker server is installed as a VM, so if the VM isn't running, docker won't work. If the `docker` command isn't working, double-check that the VM is running with `vagrant status`, or restart it with `vagrant reload`.
