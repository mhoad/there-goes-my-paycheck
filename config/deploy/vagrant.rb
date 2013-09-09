set :user, "vagrant"
server "192.168.33.10", :app, :web, :db, :primary => true
set :deploy_to, "/var/www/paycheck"