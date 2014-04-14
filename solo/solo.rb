file_cache_path "/var/chef-solo"
cookbook_path ["/var/chef-solo/chef-solo-repo/cookbooks",
               "/var/chef-solo/chef-solo-repo/site-cookbooks"]
role_path "/var/chef-solo/chef-solo-repo/roles"
data_bag_path "/var/chef-solo/chef-solo-repo/data-bags"

# Recommend to protect against man-in-the-middle attacks
ssl_verify_mode :verify_peer

