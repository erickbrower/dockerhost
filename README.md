## dockerhost

Easily install and configure a Docker server on Mac OS X. 

### Prerequisites

* Install [Vagrant](http://vagrantup.com)
* Install [VirtualBox](http://www.virtualbox.org)
* Install [Docker](http://docker.io) client. The quickest way is with `brew install docker`

### Install (Simple)
`curl -L https://raw.github.com/erickbrower/dockerhost/master/install.sh | sh`

Vagrant will prompt you to enter your OS X password for mounting the shared folder via NFS. When the process is finished, check the installation with `docker pull erickbrower/rails`

### Install (Manual)
Seriously though, just do the simple install.

1. `echo 'export DOCKERHOST=~/.dockerhost' >> ~/.bashrc` (or zshrc, if you use zsh)
2. `echo 'export DOCKER_HOST=tcp://localhost:2375' >> ~/.bashrc`
3. `. ~/.bashrc`
4. `git clone git@github.com:erickbrower/dockerhost.git $DOCKERHOST`
5. `(cd $DOCKERHOST && vagrant up)`


### Configure
These ENV vars are checked in the Vagrantfile and used to override default values. 

ENV Variable          | Default         | Notes 
--------------------- | --------------- | -----
`DOCKERHOST`          | `~/.dockerhost` | The directory where this source will be cloned. Vagrant commands like `vagrant ssh` should be run from here.
`DOCKERHOST_PROJECTS` | `~/Workbench`   | The directory that will be synced to the VM at `/home/core/share`. All mounted volumes in your docker commands will actually be relative to this directory. Ex, `/home/core/share/my_project:/opt/app`
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
