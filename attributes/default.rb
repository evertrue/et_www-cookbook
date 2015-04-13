set['apache']['listen_ports'] = ['80']
set['apache']['contact'] = 'devops@evertrue.com'
set['apache']['docroot'] = '/var/www/www.evertrue.com/current/htdocs'
set['apache']['server_name'] = 'www.evertrue.com'
set['apache']['server_aliases'] = [
  'evertrue.com',
  'old.evertrue.com',
  'new.evertrue.com',
  'www.evertruemobile.com',
  'evertruemobile.com',
  'admin.evertrue.com'
]

# Set Apache modules to enable
set['apache']['default_modules'] = %w(
  status
  alias
  auth_basic
  authn_file
  authz_groupfile
  authz_host
  authz_user
  dir
  env
  mime
  setenvif
  deflate
  expires
  headers
  log_config
  logio
  php5
)

# mod_status Allow list, space separated list of allowed entries
set['apache']['status_allow_list'] = '127.0.0.1 localhost ip6-localhost'
# Set ExtendedStatus to true to supply MeetMe New Relic plugin w/ metrics
set['apache']['ext_status'] = true

set['et_www']['user'] = 'deploy'
set['et_www']['group'] = 'deploy'
