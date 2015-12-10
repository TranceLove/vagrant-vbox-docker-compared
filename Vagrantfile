# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'json'

VAGRANTFILE_API_VERSION = "2"
CHEF_VERSION = "11.10.0"
VAGRANT_DEFAULT_PROVIDER = "virtualbox"

#Load deploy JSON from separate file.
#Technique referenced from https://github.com/le0pard/chef-solo-example/blob/master/Vagrantfile
CHEF_JSON = JSON.parse(Pathname(__FILE__).dirname.join('deploy.json').read)

Vagrant.require_version ">= 1.6.0"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.omnibus.chef_version = CHEF_VERSION
    config.omnibus.install_url = "./chef-install.sh"
    config.berkshelf.enabled = true

    config.vm.define 'mongodb' do |mongodb|
        mongodb.vm.box = "opscode_ubuntu-14.04_chef-provisionerless"
        mongodb.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"
        mongodb.vm.host_name = 'mongodb'
        mongodb.vm.network "private_network", ip: "192.168.250.11"
        mongodb.vm.network :forwarded_port, host: 27017, guest: 27017

        mongodb.vm.provider "virtualbox" do |vm|
            vm.customize ["modifyvm", :id, "--cpus", 1]
            vm.customize ["modifyvm", :id, "--memory", 768]
        end

        mongodb.vm.provision "chef_solo" do |chef|
            chef.roles_path = "roles"
            chef.add_role "mongodb"
            chef.json = CHEF_JSON
        end

    end

    config.vm.define 'ws1' do |ws1|
        ws1.vm.box = "opscode_ubuntu-14.04_chef-provisionerless"
        ws1.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"
        ws1.vm.host_name = 'ws1'
        ws1.vm.network "private_network", ip: "192.168.250.21"
        ws1.vm.network :forwarded_port, host: 8999, guest: 8999

        config.vm.provider "virtualbox" do |vm|
            vm.customize ["modifyvm", :id, "--cpus", 1]
            vm.customize ["modifyvm", :id, "--memory", 256]
        end

        ws1.vm.provision "chef_solo" do |chef|
            chef.roles_path = "roles"
            chef.add_role "ws"
            chef.json = CHEF_JSON
        end

    end
end
