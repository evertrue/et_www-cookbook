#
# Cookbook Name:: et_www
# Recipe:: default
#
# Copyright (C) 2013 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#

case node['platform_family']
when 'debian'
  include_recipe 'apt'

  %w(trusty trusty-updates trusty-security).each do |distro|
    apt_repository "#{distro}-multiverse" do
      uri          'http://us-east-1.ec2.archive.ubuntu.com/ubuntu/'
      distribution distro
      components   ['multiverse']
      deb_src      true
      notifies     :run, 'execute[apt-get update]', :immediately
    end
  end
end

include_recipe 'storage'
include_recipe 'apache2'
include_recipe 'apache2::mod_fastcgi'
include_recipe 'git'
include_recipe 'php'

php_fpm_pool 'evertrue' do
  max_children 48
  start_servers 10
  min_spare_servers 10
  max_spare_servers 10
  additional_config(
    'catch_workers_output' => 'yes',
    'max_requests' => 200
  )
end

# Ensure mysqldump is present
package 'mysql-client-5.6'
package 'subversion'
package 'libapache2-mod-rpaf'

apache_mod 'rpaf'

# Set up PHP-FPM with the FastCGI mod
apache_conf 'php-fpm'

# Install some excellent Apache config rules, courtesy of h5bp.com
apache_conf 'h5bp'

user node['et_www']['user'] do
  comment 'Deploy worker, set up by Chef'
  shell '/bin/bash'
  home "/home/#{node['et_www']['user']}"
  supports manage_home: true
end

include_recipe 'et_www::vhost'
include_recipe 'composer'
