## dockerhost

A simple CoreOS instance as your Docker server on Mac OS X. 

### Install (Simple)
`curl -L https://raw.github.com/erickbrower/dockerhost/master/install.sh | sh`

### Install (Manual)

1. `git clone git@github.com:erickbrower/dockerhost.git`
2. `cd dockerhost`
3. `vagrant up` (This will prompt you for your OS X admin password after a few seconds)
4. `echo 'export DOCKER_HOST=tcp://localhost:2375' >> ~/.bashrc` (or zshrc, if you use zsh)
5. `source ~/.bashrc`

### Install the Docker client

The simplest way is  `brew install docker`. Then check that your server is installed correctly by running `docker pull erickbrower/rails`

### Configure
These ENV vars are checked in the Vagrantfile and used to override default values. Set any of them in your `~/.bashrc` with `export STUFF=thing`, and source them with `. ~/.bashrc`. Be sure to `vagrant reload` to apply any new configurations.

* `DOCKERHOST_PROJECTS` - Default: `~/Workbench`. The dir that will be synced with the VM. All VOLUME mounts in your docker commands that attempt to mount a directory on the host will actually be checking this directory.
* `DOCKERHOST_MEMORY` - Default: 2048MB
* `DOCKERHOST_CPUS` - Default: 2

### Using 

The docker server is installed as a VM, so if the VM isn't running, docker won't work. If the `docker` command isn't working, double-check that the VM is running, or restart it with `vagrant reload`.

### Ports

The 49000 to 49900 port range is forwarded to OS X, so be sure to set the `publish` value for your docker container to something in that range. Ex., `--publish 49100:8080`. 