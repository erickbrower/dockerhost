# -*- mode: ruby -*-
# # vi: set ft=ruby :

Vagrant.require_version '>= 1.6.0'

update_channel = 'beta'

Vagrant.configure('2') do |config|
  config.vm.box = 'coreos-%s' % update_channel
  config.vm.box_version = '>= 308.0.1'
  config.vm.box_url = 'http://%s.release.core-os.net/amd64-usr/current/coreos_production_vagrant.json' % update_channel

  config.vm.provider :vmware_fusion do |vb, override|
    override.vm.box_url = 'http://%s.release.core-os.net/amd64-usr/current/coreos_production_vagrant_vmware_fusion.json' % update_channel
  end

  config.vm.provider :virtualbox do |v|
    # On VirtualBox, we don't have guest additions or a functional vboxsf
    # in CoreOS, so tell Vagrant that so it can be smarter.
    v.gui = false
    v.memory = ENV['DOCKER_HOST_VB_MEMORY'] || 2048
    v.cpus = ENV['DOCKER_HOST_VB_CPUS'] || 2
    v.check_guest_additions = false
    v.functional_vboxsf = false
  end

  (49000..49900).each do |port|
    config.vm.network :forwarded_port, :host => port, :guest => port
  end

  config.vm.network 'forwarded_port', guest: 2375, host: 2375

  # plugin conflict
  if Vagrant.has_plugin?('vagrant-vbguest') then
    config.vbguest.auto_update = false
  end

  config.vm.network :private_network, ip: '10.1.2.3'

  config.vm.synced_folder '.', '/home/core/share', id: 'core', :nfs => true, :mount_options => ['nolock,vers=3,udp']

  config.vm.provision :file, source: './docker-tcp.socket', destination: '/home/core/docker-tcp.socket'
  config.vm.provision :shell, path: './enable_docker_socket.sh'
end
