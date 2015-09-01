name             'et_www'
maintainer       'EverTrue, Inc.'
maintainer_email 'devops@evertrue.com'
license          'All rights reserved'
description      'Installs/Configures et_www'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '5.0.0'

depends 'apt'
depends 'apache2', '~> 3.0'
depends 'php',     '~> 1.4'
depends 'git'
depends 'composer',               '~> 2.0'
depends 'storage',                '~> 2.2'
