## vagrant-vbox-to-docker-compared

### A study on migrating development environment setup from vagrant+VirtualBox to vagrant+docker

This repository hosts a development environment of a node.js web application
using Vagrant (http://vagrantup.com), with VirtualBox (http://virtualbox.org)
and Docker (http://docker.io) as the underlying container/virtual machine
running the services.

To speed up time on setting up the development environment, we are studying the
efforts required to migrate from VirtualBox-based to a Docker-based setup. Hence
come to this repository.

Master branch will only carry the README file (what you are reading), recipe for
the node.js app and the node.js app itself. Please switch between `docker` and
`vbox` branches to compare the differences between the two workflows.

#### Docker-based development environment setup

Vagrant added support of Docker as "virtual machine" provider since 1.6. However,
we cannot take it as a direct drop-in replacement to VirtualBox, because

 * Docker is _not_ virtual machine. Its running unit is called container instead
 * Docker daemon will only watch the specified process, in order to determine if
 the container is running
 * No SSH available. In other words `vagrant ssh` is not available
 * Because of this, provisioning with Chef from Vagrant will become impossible since
 Vagrant needs SSH into the container in order to complete the provisioning process
 * When container preparation is completed, the process should already been started.
 Share folder for the application to run is already too late

In fact, Docker has its own way of provisioning: the Dockerfile. If you still want
to use Chef as container provisioning, we will need to make Chef run when Docker
build the image using the specified Dockerfile.

Read Dockerfile.mopngodb and Dockerfile.ws for details.

#### Using the Docker-based development environment

 1. `vagrant plugin install vagrant-berkshelf vagrant-omnibus`
 2. Install Docker and make sure Docker daemon is up and running
 3. Make sure you can run `docker` without root permission
 4. Install Chef development kit
 5. `berks install && berks vendor cookbooks`
 6. `vagrant up mongodb ws1 --provider=docker --no-parallel`

To login into the containers, use `docker ps` to locate your container's name,
then say

`docker exec -it <container name> bash`

and you will get a bash shell.
