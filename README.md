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

Please refer to the VWranglers site for instructions on how to get started
with Chef and Berkshelf:

* https://espaces.edu.au/vwrangler/deployment-tools/opscode-chef-how-tos/getting-started-with-berkshelf

Using the Bootstrap scripts
===========================

NeCTAR bootstrap
----------------

Put the following into the "Customization Script" box:

```
#!/bin/sh
wget -O - https://github.com/nectar-cookbooks/chef-solo-repo/blob/dev/scripts/bootstrap-nectar.sh | /bin/sh
```

