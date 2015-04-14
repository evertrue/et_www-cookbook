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
