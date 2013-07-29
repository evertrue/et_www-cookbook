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
include_recipe "et_users::evertrue"

apache_module "php5" do
  filename "libphp5.so"
end

directory node['apache']['docroot'] do
  owner "deploy"
  group "deploy"
  mode 00755
  action :create
end

web_app "evertrue_com" do
  server_name node['apache']['server_name']
  server_aliases node['apache']['server_aliases']
  docroot node['apache']['docroot']
end