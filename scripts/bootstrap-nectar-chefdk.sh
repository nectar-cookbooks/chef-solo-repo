#!/bin/sh
#
# See the chef-solo-repo README.md file for instructions
#
echo "**** Installing required packages ****"
if [ -e /usr/bin/yum ] ; then
  yum -y -q install curl git
  LOW_USER=ec2-user
else
  apt-get -y -qq update
  apt-get -y -qq install curl git 
  LOW_USER=ubuntu
fi

echo
echo "**** Installing ChefDK ****"
if [ -e /usr/bin/yum ] ; then
    curl https://opscode-omnibus-packages.s3.amazonaws.com/el/6/x86_64/chefdk-0.2.0-2.el6.x86_64.rpm > chefdk-0.2.0-2.el6.x86_64.rpm
    rpm -i chefdk-0.2.0-2.el6.x86_64.rpm
else
    curl https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_0.2.0-2_amd64.deb > chefdk_0.2.0-2_amd64.deb
    dpkg --install chefdk_0.2.0-2_amd64.deb
fi

echo
echo "**** Initializing the local 'repo' ****"
mkdir /var/chef-solo
chown $LOW_USER /var/chef-solo
cd /var/chef-solo
sudo -u $LOW_USER git clone https://github.com/nectar-cookbooks/chef-solo-repo.git
cd chef-solo-repo
sudo -u $LOW_USER cp solo/sample-node.json mynode.json 

echo
echo "**** Fetching cookbooks ****"
sudo -u $LOW_USER /usr/local/bin/berks vendor cookbooks

echo
echo "**** First chef run ... does basic setup ****"
chef-solo -c solo/solo.rb -j mynode.json

echo 
echo "**** Bootstrap sequence completed ****"

