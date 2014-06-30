## dockerhost

Easily install and configure a Docker server on Mac OS X. 

### Prerequisites

* Install [Vagrant](https://www.vagrantup.com/downloads)
* Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* Install [Docker](http://docker.io) client. The quickest way is with `brew install docker`

### Install
`curl -L https://raw.github.com/erickbrower/dockerhost/master/install.sh | sh`

Vagrant will prompt you to enter your OS X password for mounting the shared folder via NFS. When the process is finished, check the installation with `docker pull erickbrower/rails`

### Using 

`dh up`

The `docker` command should work now. Go forth and create containers!

dockerhost installs a tiny wrapper script called `dh` for managing the VM. If you ever need to run a [Vagrant command](http://docs.vagrantup.com/v2/cli/index.html) on your dockerhost, just pass it to `dh` instead. Some examples:

* `dh reload`
* `dh ssh`
* `dh status`

It's really just a shortcut for `(cd $DOCKERHOST && vagrant <the command>)`. No magic, just convenience.

### Configure (Optional)

These ENV vars are checked in the Vagrantfile and used to override default values. 

ENV Variable          | Default         | Notes 
--------------------- | --------------- | -----
`DOCKERHOST`          | `~/.dockerhost` | The directory where this source will be cloned.
`DOCKERHOST_PROJECTS` | `~/Workbench`   | The directory that will be synced to the VM at `/home/core/share`. All mounted volumes in your docker commands should be relative to this directory. Ex, `/home/core/share/my_project:/opt/app`
`DOCKERHOST_MEMORY` | 2048              | 
`DOCKERHOST_CPUS`   | 2                 | 

An example of overriding would look something like this, in `~/.bashrc`

```
...

export DOCKERHOST_PROJECTS='~/MyProjects'
export DOCKERHOST_MEMORY='4096'
```

Remember to reload the VM with `dh reload` after setting any of these. 

### Ports

The default Docker port range, 49000 to 49900, is forwarded to OS X. When you publish ports for your containers, be sure to use something in that range. Ex., `--publish 49100:8080`. 

### Shameless Plug

Check out my [dockerfiles repo](http://github.com/erickbrower/dockerfiles), it might have an image you need. 
