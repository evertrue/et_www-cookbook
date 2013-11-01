site :opscode

metadata

cookbook 'et_users', git: 'git@github.com:evertrue/et_users-cookbook.git'
cookbook 'chef-solo-search', github: 'edelight/chef-solo-search'
cookbook 's3fs', '2.0.0', chef_api: :config
cookbook 'newrelic-ng', '~> 0.4.0'

group :integration do
  cookbook 'minitest-handler'
end
