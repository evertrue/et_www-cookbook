#
# Cookbook Name:: et_www
# Recipe:: newrelic
#
# Copyright (C) 2013 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#

nr_license = data_bag_item('secrets', 'api_keys')['newrelic']
node.set['newrelic_meetme_plugin']['license'] = nr_license
node.set['newrelic']['license'] = nr_license

# Install the New Relic PHP Agent
include_recipe 'newrelic::php_agent'

# Install the New Relic MeetMe Plugin Agent
# include_recipe 'newrelic_meetme_plugin'
