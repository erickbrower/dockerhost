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
These ENV vars are checked in the Vagrantfile and used to override default values. 

ENV Variable          | Default         | Notes 
--------------------- | --------------- | -----
`DOCKERHOST`          | `~/.dockerhost` | The directory where this source will be cloned. Vagrant commands like `vagrant ssh` should be run from here.
`DOCKERHOST_PROJECTS` | `~/Workbench`   | The directory that will be synced with the VM. All VOLUME mounts in your docker commands that attempt to mount a directory on the host will actually be checking this directory.
`DOCKERHOST_MEMORY` | 2048              | 
`DOCKERHOST_CPUS`   | 2                 | 

An example of overriding would look something like this, in `~/.bashrc`

```
...

export DOCKERHOST_PROJECTS='~/MyProjects'
export DOCKERHOST_MEMORY='4096'
```

Remember to reload the vm with `vagrant reload` after setting any of these. 

### Using 

The docker server is installed as a VM, so if the VM isn't running, docker won't work. If the `docker` command isn't working, check the VM with `vagrant status`, or restart it with `vagrant reload`. A handy shortcut syntax for cd'ing to the dockerhost directory and running a vagrant command is `(cd $DOCKERHOST && vagrant <the command>)`. The parens execute the statement in a subshell so you don't actually leave your current directory. 

### Ports

The 49000 to 49900 port range is forwarded to OS X, so be sure to set the `publish` value for your docker container to something in that range. Ex., `--publish 49100:8080`. 

### Shameless Plug

Check out my [dockerfiles repo](http://github.com/erickbrower/dockerfiles), it might have an image you need. 