#!/bin/sh
# 
# Cheatsheet for vagrant deployment:
# 0. Install vagrant
# 1. Use "vagrant init ..." to create the VagrantFile
# 2. Edit the Vagrant to add a line like this:
#
#    config.vm.provision :shell, :path => "bootstrap.sh"
#
# 3. Copy this script to "bootstrap.sh" in the same dir as the VagrantFile  
# 4. Provision by running "vagrant up" ... etcetera
#

if [ -e /usr/bin/yum ] ; then
  yum -y -q install curl git gcc gcc-c++ ruby-devel tar autoconf
else
  apt-get -y -qq update
  apt-get -y -qq install curl git build-essential ruby-dev
fi
bash -c "curl -L https://www.opscode.com/chef/install.sh | bash"
/opt/chef/embedded/bin/gem install --no-rdoc --no-ri berkshelf
ln -s /opt/chef/embedded/bin/berks /usr/local/bin
mkdir /var/chef-solo
chown vagrant /var/chef-solo
su - vagrant -c "cd /var/chef-solo ; git clone https://github.com/nectar-cookbooks/chef-solo-repo.git ; cd /var/chef-solo/chef-solo-repo ; cp solo/vagrant-node.json vagrant.json ; berks install --path cookbooks"
chef-solo -c /var/chef-solo/chef-solo-repo/solo/solo.rb -j /var/chef-solo/chef-solo-repo/vagrant.json
