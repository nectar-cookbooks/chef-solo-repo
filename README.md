Purpose
=======

This git repo contains "Berkshelf" prepopulated with the core NeCTAR 
cookbook collection (and dendencies), together with sample configs for 
Chef Solo.  The aim of this repo is:

* to support the "quick start" procedure for Chef Solo + Berkshelf 
  described below, and

* to facilitate "pulling" updates to the NeCTAR cookbook collection.

Introduction to Chef and Berkshelf
==================================

Opscode Chef is system for automating the configuration of (typically) Linux / 
UNIX based machines and virtuals.  See http://www.opscode.com/chef/ for details.
There is also a growing body of relevant information in the Virtual Wranglers 
espace at https://espaces.com.au/vwrangler.

The basic idea is that configuration tasks are performed using Recipes.  These
are (mostly) declarative scripts written in the Chef's Ruby-based "domain 
specific language".  Recipes are run on "nodes" (i.e. computers) which are
configured using Node and Role specifications.  These typically say what Recipes
to run, and provide various attributes that parameterize the Recipe behaviour.
Recipes and their associated files are bundled up as Cookbooks, and the whole
lot are (typically) checked into version control.

Chef can either be used in two ways:

* You can use a central server to hold all of the configuration specifications,
and manage the configuration state and authorization details.  This mode of
operation is best if you have a number of machines to manage, but it requires
you to either set up and maintain a Chef server, or use the "Enterprise Chef"
service managed by Opscode.  (The latter is free for up to 5 nodes.  After that
you pay by the month.)

* You can use Chef solo mode where you essentially manage each system 
individually, and take care of the distribution of configuration specs and
state yourself.  (Chef solo does not support shared Data Bags or dynamic Node 
attribute storage ... or any form of authorization.)

Berkshelf is a tool for managing the collection of Cookbooks that you use.  It deals with downloading the cookbooks from various sources, dependencies between cookbooks, and version locking.

Getting Started
===============

There is lots of material on the Opscode site about how to use Chef in its
various forms.  But here's a quick "cheat sheet" to get yourself started with
Chef Solo and the recipes in this repo:

1. Install git and the dependencies for Berkshelf.

         sudo yum install git gcc gcc-c++ ruby-devel

   or

         sudo apt-get install git build-essential ruby-dev

2. Install the latest version of Chef:

         sudo bash -c "true && curl -L https://www.opscode.com/chef/install.sh | bash"

3. Install Berkshelf and add 'berks' to your path

         sudo /opt/chef/embedded/bin/gem install berkshelf
         sudo ln -s /opt/chef/embedded/bin/berks /usr/local/bin

4. Create a directory for doing chef solo work:

         sudo mkdir /var/chef-solo
         sudo chown <your-id> /var/chef-solo

5. Clone this repo:

         cd /var/chef-solo
         git clone <the url>
         cd cvl-chef

6. Install the dependent cookbooks:

         berks install

7. Make a node definition:

         cp solo/sample-node.json mynode.json
         # edit mynode.json to add override attributes, 
         #    change the runlist and so on

8. Run the using chef-solo

         sudo chef-solo -c solo/solo.rb -j mynode.json -ldebug

If you intend to "get serious" with Chef, will need to do a lot more reading.  In addition, you will need to look into things like:
* version control and backup of your "chef-solo" tree; e.g. the 'mynode.json', and
* using Chef Server, either in the Open Source (unsupported) or Enterprise flavours.

