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
include_recipe "newrelic::repository"
include_recipe "newrelic::php-agent"
include_recipe "newrelic-ng::plugin-agent-install"

apache_module "php5" do
  filename "libphp5.so"
end

# Install PHP's MySQL module
package "php5-mysql" do
  action :install
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

newrelic_ng_plugin_agent 'custom' do
  license_key node['newrelic-ng']['plugin-agent']['license_key']

  # additional plugin-agent configuration options
  poll_interval  60
  logfile        '/tmp/plugin-agent.log'
  pidfile        '/tmp/plugin-agent.pid'

  # set your service configuration
  service_config <<-EOS
apache_httpd:
  scheme: http
  host: localhost
  verify_ssl_cert: true
  port: 80
  path: /server-status

php_apc:
  scheme: http
  host: localhost
  verify_ssl_cert: true
  port: 80
  path: /apc-nrp.php
EOS
end
