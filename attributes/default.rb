set['apache']['listen_ports'] = ["80"]
set['apache']['docroot'] = "/var/www/www.evertrue.com/current/htdocs"
set['apache']['server_name'] = "www.evertrue.com"
set['apache']['server_aliases'] = [
  'evertrue.com',
  'old.evertrue.com',
  'new.evertrue.com',
  'www.evertruemobile.com',
  'evertruemobile.com',
  'admin.evertrue.com'
]
set['apache']['allow_override'] = [ 'All' ]
