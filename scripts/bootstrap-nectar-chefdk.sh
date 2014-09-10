#!/bin/sh
#
# See the chef-solo-repo README.md file for instructions
#
echo "**** Installing required packages ****"
if [ -e /usr/bin/yum ] ; then
  yum -y -q install curl git gcc gcc-c++ ruby-devel tar autoconf mysql-devel 
  LOW_USER=ec2-user
else
  apt-get -y -qq update
  apt-get -y -qq install curl git build-essential libmysqlclient-dev
  LOW_USER=ubuntu
fi

VER=0.2.1-1

echo
echo "**** Installing ChefDK ****"
if [ -e /usr/bin/yum ] ; then
    # officially RHEL 6 only, but with luck this will work on recent Fedora 
    # and RHEL 7 platforms too
    curl https://opscode-omnibus-packages.s3.amazonaws.com/el/6/x86_64/chefdk-${VER}.el6.x86_64.rpm > chefdk-${VER}.el6.x86_64.rpm
    rpm -i chefdk-${VER}.el6.x86_64.rpm
else
    # from ChefDK 0.2.0 onwards, there 12.04 deb is used on 13.10 also ...
    # and I guess later too
    curl https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_${VER}_amd64.deb > chefdk_${VER}_amd64.deb
    dpkg --install chefdk_${VER}_amd64.deb
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
sudo -u $LOW_USER berks vendor cookbooks

echo
echo "**** First chef run ... does basic setup ****"
chef-solo -c solo/solo.rb -j mynode.json

echo 
echo "**** Bootstrap sequence completed ****"

