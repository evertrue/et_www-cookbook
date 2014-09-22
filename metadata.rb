name             'et_www'
maintainer       'EverTrue, Inc.'
maintainer_email 'devops@evertrue.com'
license          'All rights reserved'
description      'Installs/Configures et_www'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.4.0'

depends 'et_users'
depends 'apt'
depends 'apache2', '~> 1.6'
depends 'php',     '~> 1.4'
depends 'git'
depends 'newrelic-ng', '~> 0.4'
