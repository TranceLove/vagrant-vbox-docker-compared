# Base Vagrant box

FROM dockerize/ubuntu

#Optional, update mirrors speedups updates, but some mirrors sometimes fail
#RUN sed -i -e 's,http://[^ ]*,mirror://mirrors.ubuntu.com/mirrors.txt,' /etc/apt/sources.list

#update apt sources
RUN apt-get update --fix-missing

# Optional, upgrade to latest (takes a while), but before install sshd
RUN apt-get upgrade -y

# Default locale
RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 && update-locale LANG=en_US.UTF-8

#install required packages
RUN apt-get install -y apt-utils sudo curl wget nfs-common upstart vim vim-common mc git && \
    apt-get clean #cleanup to reduce image size

# Create and configure vagrant user
RUN useradd --create-home -s /bin/bash vagrant
WORKDIR /home/vagrant

# Configure sudo right
RUN adduser vagrant sudo && \
    `# Enable passwordless sudo for users under the "sudo" group` && \
    sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers && \
    echo -n 'vagrant:vagrant' | chpasswd

# Mount virtualisation environment to /vagrant
ADD . /vagrant

# Install chef
RUN dpkg -i /vagrant/chef_11.10.0-1.ubuntu.13.04_amd64.deb

# Run chef recipes
RUN /opt/chef/bin/chef-solo -c /vagrant/deploy.rb -j /vagrant/deploy.json --override-runlist "role[ws]"

# Expose port 8999 for web service
EXPOSE 8999

# Copy server source files
RUN mkdir -p /srv/www/test-server && cp -r /vagrant/node-server/** /srv/www/test-server && chown deploy:www-data -R /srv/www/test-server

#Change to deploy
USER deploy
ENV HOME="/home/deploy"
WORKDIR /srv/www/test-server

CMD pm2 start server.js -x -i 1 --no-daemon
