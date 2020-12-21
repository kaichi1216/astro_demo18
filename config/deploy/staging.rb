server '172.105.241.122', user: 'deploy', roles: %w{app web db}
set :deploy_to, '/home/deploy/staging'