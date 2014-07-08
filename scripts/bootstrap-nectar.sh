#!/bin/sh
#
# See the chef-solo-repo README.md file for instructions
#
if [ -e /usr/bin/yum ] ; then
  yum -y -q install curl git gcc gcc-c++ ruby-devel tar autoconf
  LOW_USER=ec2-user
else
  apt-get -y -qq update
  apt-get -y -qq install curl git build-essential ruby-dev
  LOW_USER=ubuntu
fi
bash -c "curl -L https://www.opscode.com/chef/install.sh | bash"
/opt/chef/embedded/bin/gem install --no-rdoc --no-ri berkshelf
ln -s /opt/chef/embedded/bin/berks /usr/local/bin
mkdir /var/chef-solo
chown $LOW_USER /var/chef-solo
cd /var/chef-solo
sudo -u $LOW_USER git clone https://github.com/nectar-cookbooks/chef-solo-repo.git
cd chef-solo-repo
sudo -u $LOW_USER cp solo/sample-node.json mynode.json 
sudo -u $LOW_USER /usr/local/bin/berks vendor cookbooks
chef-solo -c solo/solo.rb -j mynode.json
