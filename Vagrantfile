# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'json'

VAGRANTFILE_API_VERSION = "2"
CHEF_VERSION = "11.10.0"
#avoids having to $ vagrant up --provider docker
ENV['VAGRANT_DEFAULT_PROVIDER'] ||= 'docker'

#Load deploy JSON from separate file.
#Technique referenced from https://github.com/le0pard/chef-solo-example/blob/master/Vagrantfile
CHEF_JSON = JSON.parse(Pathname(__FILE__).dirname.join('deploy.json').read)

Vagrant.require_version ">= 1.6.0"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.omnibus.chef_version = CHEF_VERSION
    config.omnibus.install_url = "provision/chef-install.sh"
    config.berkshelf.enabled = true

    config.vm.define 'mongodb' do |mongodb|
        mongodb.vm.host_name = 'mongodb'
        mongodb.vm.network :forwarded_port, host: 27017, guest: 27017
        mongodb.vm.provider 'docker' do |d|
            #use a prebuilt image ie 'npoggi/vagrant-docker:latest'
            if ENV['DOCKER_IMAGE'] then
                print 'Using docker image ' + ENV['DOCKER_IMAGE'] +' (downloads if necessary)\n'
                d.image = ENV['DOCKER_IMAGE']
            else
                #build from the Dockerfile
                d.build_dir = '.'
                d.dockerfile = 'Dockerfile.mongodb'
                d.name = 'mongodb-docker'
            end

            d.has_ssh = false
            d.remains_running = true
        end

        #config.vm.provision :shell, :path => 'cd /tmp/provision && bash ./bootstrap.sh'
        #config.vm.synced_folder "provision", "/tmp/provision"

        # mongodb.vm.provision "chef_solo" do |chef|
        #     chef.roles_path = "roles"
        #     chef.add_role "mongodb"
        #     chef.json = CHEF_JSON
        # end

    end

    config.vm.define 'ws1' do |ws1|
        ws1.vm.host_name = 'ws1'
        ws1.vm.network :forwarded_port, host: 8999, guest: 8999
        ws1.vm.provider 'docker' do |d|
            #use a prebuilt image ie 'npoggi/vagrant-docker:latest'
            if ENV['DOCKER_IMAGE'] then
                print 'Using docker image ' + ENV['DOCKER_IMAGE'] +' (downloads if necessary)\n'
                d.image = ENV['DOCKER_IMAGE']
            else
                #build from the Dockerfile
                d.build_dir = '.'
                d.dockerfile = 'Dockerfile.ws'
                d.name = 'ws-docker'
            end

            d.has_ssh = false
            d.remains_running = true
            d.link("mongodb-docker:mongodb")
        end

        #config.vm.provision :shell, :path => 'cd /tmp/provision && bash ./bootstrap.sh'
        #config.vm.synced_folder "provision", "/tmp/provision"

        # ws1.vm.provision "chef_solo" do |chef|
        #     chef.roles_path = "roles"
        #     chef.add_role "ws1"
        #     chef.json = CHEF_JSON
        # end

    end
end
