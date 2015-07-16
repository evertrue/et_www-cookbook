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
  php5-apcu
).each do |pkg|
  package pkg
end

# Install WP-CLI
remote_file '/usr/local/bin/wp' do
  mode '0755'
  source 'https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar'
end

group node['et_www']['group'] do
  members node['apache']['group']
  action :modify
  append true
end

%w(
  stage-www
  www
).each do |subdomain|
  site_dir = "/var/www/#{subdomain}.evertrue.com"
  [
    site_dir,
    "#{site_dir}/shared",
    "#{site_dir}/shared/web",
    "#{site_dir}/shared/web/app"
  ].each do |dir|
    directory dir do
      owner node['et_www']['user']
      group node['apache']['group']
      mode 02775
    end
  end

  if subdomain == 'stage-www'
    wp_env = 'staging'
    db = 'stage-etwp'
  else
    wp_env = 'production'
    db = 'etwp'
  end

  db_creds = data_bag_item('secrets', 'database_credentials')[node.chef_environment][db]

  template "#{site_dir}/shared/.env" do
    variables(
      db_name: db,
      db_user: db_creds['username'],
      db_pass: db_creds['password'],
      db_host: 'www.cg0lvth7azzh.us-east-1.rds.amazonaws.com',
      wp_env: wp_env,
      subdomain: subdomain
    )
  end

  file "#{site_dir}/shared/web/.htaccess" do
    owner node['et_www']['user']
    group node['apache']['group']
    mode '664'
  end

  if node['storage']['ephemeral_mounts']
    directory   "#{node['storage']['ephemeral_mounts'].first}/#{subdomain}/uploads" do
      owner     node['et_www']['user']
      group     node['apache']['group']
      mode      '2775'
      recursive true
    end

    link "#{site_dir}/shared/web/app/uploads" do
      to "#{node['storage']['ephemeral_mounts'].first}/#{subdomain}/uploads"
    end
  end
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
  docroot '/var/www/stage-www.evertrue.com/current/web'
  allow_override %w(All)
end
