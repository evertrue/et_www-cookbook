name             'et_www'
maintainer       'EverTrue, Inc.'
maintainer_email 'eric.herot@evertrue.com'
license          'All rights reserved'
description      'Installs/Configures et_www'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.6.3'

depends 'et_users'
depends 'apt'
depends 'apache2'
depends 'php'
depends 's3fs'
depends 'git'
