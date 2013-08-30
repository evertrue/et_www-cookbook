apache_module "php5" do
  filename "libphp5.so"
end

# Install PHP's MySQL module
package "php5-mysql" do
  action :install
end

# Install PHP cURL module
package "php5-curl" do
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
cookbook_file "#{node['apache']['dir']}/conf.d/h5bp.conf" do
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
