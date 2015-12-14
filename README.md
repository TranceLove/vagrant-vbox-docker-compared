## vagrant-vbox-to-docker-compared

### A study on migrating development environment setup from vagrant+VirtualBox to vagrant+docker

This repository hosts a development environment of a node.js web application
using Vagrant (http://vagrantup.com), with VirtualBox (http://virtualbox.org)
and Docker (http://docker.io) as the underlying container/virtual machine
running the services.

To speed up time on setting up the development environment, we are studying the
efforts required to migrate from VirtualBox-based to a Docker-based setup. Hence
come to this repository.

#### VirtualBox-based development environment setup

Vagrant with VirtualBox was our initial combination. We also used Puppet (https://puppetlabs.com/)
in the beginning, and we changed to Chef (https://chef.io) for compatibility with
AWS Opsworks.

Not much tricks here, everything is quite straightforward. Techniques used here
are from various sources.

The original idea of making local development environment similar to Opsworks:
http://pixelcog.com/blog/2014/virtualizing-aws-opsworks-with-vagrant/

(This repository didn't have dependency with AWS cookbooks nor Opsworks agent;
in our own projects we do however.)

Use of external JSON file to declare deployment environment:
https://github.com/le0pard/chef-solo-example

The biggest difference of this local development environment with Opsworks however,
is Opsworks have strict separation of instance lifecycle events, e.g. instance
setup, instances added to a layer, application deploy/undeploy, and shutdown; we
don't have these here. It shouldn't put much difference, but you may want to
take care of this when you write Chef cookbooks that would work on both local
and Opsworks environments.

#### Using the VirtualBox-based development environment

 1. `vagrant plugin install vagrant-berkshelf vagrant-omnibus`
 2. Install Chef development kit
 3 `vagrant up mongodb ws1`
 4. Wait for the machines to come up

`vagrant ssh <machine name>`

and you will get a bash shell.
