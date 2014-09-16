#
# Cookbook Name:: et_www
# Recipe:: vhost
#
# Copyright (C) 2013 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#

apache_module 'php5' do
  filename 'libphp5.so'
end

# Install PHP's MySQL & cURL modules
%w(
  php5-mysql
  php5-curl
).each do |pkg|
  package pkg
end

group 'deploy' do
  members 'www-data'
  action :modify
  append true
end

directory '/var/www/www.evertrue.com' do
  owner 'deploy'
  group 'www-data'
  mode 02775
  action :create
end

# Install some excellent Apache config rules, courtesy of h5bp.com
cookbook_file "#{node['apache']['dir']}/conf.d/h5bp.conf" do
  source 'h5bp.conf'
  mode 00644
  owner 'root'
  group node['apache']['root_group']
  action :create_if_missing
end

web_app 'evertrue_com' do
  server_name node['apache']['server_name']
  server_aliases node['apache']['server_aliases']
  docroot node['apache']['docroot']
end
