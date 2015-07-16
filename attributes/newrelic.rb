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

set['newrelic']['application_monitoring']['app_name'] = 'WWW'
set['newrelic']['php_agent']['web_server']['service_name'] = 'apache2'
set['newrelic']['php_agent']['config_file'] = '/etc/php5/apache2/conf.d/newrelic.ini'
