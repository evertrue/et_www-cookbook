# New Relic application monitoring config
set['newrelic-ng']['license_key'] = Chef::EncryptedDataBagItem.load('secrets', 'api_keys')['newrelic']
set['newrelic-ng']['app_monitoring']['appname'] = 'www'
