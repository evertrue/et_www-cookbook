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
end

include_recipe 'apache2'
include_recipe 'apache2::mod_php5'

package 'libapache2-mod-rpaf'

cookbook_file "#{node['apache']['dir']}/mods-available/rpaf.conf"

apache_module 'rpaf'

include_recipe 'et_users::evertrue'
include_recipe 'git'
include_recipe 'et_www::vhost'
include_recipe 'et_www::apc'
include_recipe 'et_www::newrelic'
