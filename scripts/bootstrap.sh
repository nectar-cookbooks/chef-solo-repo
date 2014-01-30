#!/bin/sh

if [ -e /usr/bin/yum ] ; then
  yum -y install curl git gcc gcc-c++ ruby-devel
else
  apt-get -y install curl git build-essential ruby-dev
fi
bash -c "curl -L https://www.opscode.com/chef/install.sh | bash"
/opt/chef/embedded/bin/gem install --no-rdoc --no-ri berkshelf
ln -s /opt/chef/embedded/bin/berks /usr/local/bin
mkdir /var/chef-solo
chown vagrant /var/chef-solo
cd /var/chef-solo
sudo -u vagrant git clone https://github.com/nectar-cookbooks/chef-solo-repo.git
cd chef-solo-repo
sudo -u vagrant cp solo/sample-node.json mynode.json
sudo -u vagrant berks install --path cookbooks
chef-solo -c solo/solo.rb -j mynode.json
