set['newrelic']['application_monitoring']['app_name'] = 'www'
set['newrelic']['application_monitoring']['enabled'] = false
set['newrelic']['php_agent']['config_file'] = "#{node['php']['ext_conf_dir']}/newrelic.ini"

# Plugin Agent settings for Apache & APC monitoring
set['newrelic_meetme_plugin']['services'] = {
  'apache_httpd' => {
    'scheme' => 'http',
    'host'   => 'localhost',
    'port'   => 80,
    'path'   => '/server-status'
  },
  'php_apc' => {
    'scheme' => 'http',
    'host'   => 'localhost',
    'port'   => 80,
    'path'   => '/apc-nrp.php'
  }
}
