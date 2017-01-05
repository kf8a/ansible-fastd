# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "debian"
  config.vm.boot_timeout = 3600

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
  end

  config.vm.define "host1" do |host|
    host.vm.network :private_network, ip: "192.168.33.2"
  end

  config.vm.define "host2" do |host|
    host.vm.network :private_network, ip: "192.168.33.3"
  end

  config.vm.define "host3" do |host|
    host.vm.network :private_network, ip: "192.168.33.4"
  end

  config.vm.provision :ansible do |ansible|
    # ansible.extra_vars = { ansible_ssh_user: 'vagrant' }
    #ansbile_inventory_file = "fastd.hosts"
    ansible.sudo = true
    ansible.playbook = "common.yml"
  end
end
