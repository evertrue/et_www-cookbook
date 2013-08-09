#
# Cookbook Name:: et_www
# Recipe:: apc
#
# Copyright (C) 2013 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#

include_recipe "php"

# Install APC for local opscode caching
package "php-apc" do
  action :install
end

# Configure APC
template "#{node['php']['ext_conf_dir']}/apc.ini" do
  source "apc.ini.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[apache2]", :delayed
end
