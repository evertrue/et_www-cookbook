#
# Cookbook Name:: et_www
# Recipe:: newrelic
#
# Copyright (C) 2013 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#

include_recipe "newrelic::repository"
include_recipe "newrelic::php-agent"
include_recipe "newrelic::plugin-agent"

newrelic_plugin_agent 'www' do
  license_key node['newrelic']['application_monitoring']['license']

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
