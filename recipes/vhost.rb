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

# Install Debian/Ubuntu packages for PHP necessary for WP
%w(
  php5-mysql
  php5-curl
  php5-gd
  php5-imap
  php5-mcrypt
  php5-pspell
  php5-xmlrpc
).each do |pkg|
  package pkg
end

group 'deploy' do
  members 'www-data'
  action :modify
  append true
end

%w(
  stage-www
  www
).each do |subdomain|
  directory "/var/www/#{subdomain}.evertrue.com" do
    owner 'deploy'
    group 'www-data'
    mode 02775
  end
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
  allow_override %w(All)
end

web_app 'stage_evertrue_com' do
  server_name 'stage-www.evertrue.com'
  server_aliases []
  docroot '/var/www/stage-www.evertrue.com/current/htdocs'
  allow_override %w(All)
end
