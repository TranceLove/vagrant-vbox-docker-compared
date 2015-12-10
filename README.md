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
