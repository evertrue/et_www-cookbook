site :opscode

metadata

cookbook 'et_users', git: 'git@github.com:evertrue/et_users-cookbook.git'
cookbook 'chef-solo-search', github: 'edelight/chef-solo-search'
cookbook 's3fs', '2.0.0', chef_api: :config
cookbook 'newrelic', chef_api: :config

group :integration do
  cookbook 'minitest-handler'
end
