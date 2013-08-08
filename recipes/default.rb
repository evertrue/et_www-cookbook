#
# Cookbook Name:: et_www
# Recipe:: default
#
# Copyright (C) 2013 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#

case node['platform_family']
  when "debian"
    include_recipe "apt"
end

include_recipe "apache2"
include_recipe "apache2::mod_php5"
include_recipe "php"
include_recipe "et_users::evertrue"

apache_module "php5" do
  filename "libphp5.so"
end

# Install PHP's MySQL module
package "php5-mysql" do
  action :install
end

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

directory "/var/www/www.evertrue.com" do
  owner "deploy"
  group "deploy"
  mode 00755
  action :create
end

# Install basic auth for /apps
# TODO Remove this when /apps moves to its own project/vhost
cookbook_file "/var/www/www.evertrue.com/passwd_apps" do
  source "passwd_apps"
  mode 00644
  owner "deploy"
  group "deploy"
  action :create_if_missing
end

# Install some excellent Apache config rules, courtesy of h5bp.com
cookbook_file "#{node['apache']['dir']}/conf.d" do
  source "h5bp.conf"
  mode 00644
  owner "root"
  group node['apache']['root_group']
  action :create_if_missing
end

web_app "evertrue_com" do
  server_name node['apache']['server_name']
  server_aliases node['apache']['server_aliases']
  docroot node['apache']['docroot']
end
