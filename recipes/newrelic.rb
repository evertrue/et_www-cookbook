#
# Cookbook Name:: et_www
# Recipe:: newrelic
#
# Copyright (C) 2013 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#

# Install the New Relic repository, system monitor, PHP Agent & Plugin Agent
include_recipe "newrelic-ng"
include_recipe "newrelic-ng::php-agent-default"
include_recipe "newrelic-ng::plugin-agent-default"

# Pass along YAML settings for Plugin Agent for Apache & APC
node.normal['newrelic-ng']['plugin-agent']['service_config'] = <<-EOS
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
