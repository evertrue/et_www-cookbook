# New Relic application monitoring config
set['newrelic']['application_monitoring']['license'] = Chef::EncryptedDataBagItem.load("secrets","api_keys")["newrelic"]
set['newrelic']['application_monitoring']['appname'] = "www"
set['newrelic']['application_monitoring']['logfile'] = "/var/log/newrelic/php_agent.log"
