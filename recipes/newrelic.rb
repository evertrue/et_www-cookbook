#
# Cookbook Name:: et_www
# Recipe:: newrelic
#
# Copyright (C) 2013 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#

# Install the New Relic repository, system monitor, & PHP Agent
include_recipe 'newrelic'
include_recipe 'newrelic::php_agent'

# Install the New Relic MeetMe Plugin Agent
include_recipe 'newrelic_meetme_plugin'
