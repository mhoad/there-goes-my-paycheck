require "rvm/capistrano"
require "bundler/capistrano"

server "192.241.210.187", :app, :web, :db, :primary => true

 
set :application, "there-goes-my-paycheck"
set :user, "application"
set :scm, :git
set :repository,  "git@github.com:mhoad/#{application}.git"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :branch, "deployment"
set :scm_passphrase, ""
set :use_sudo, false
 
ssh_options[:forward_agent] = true
set :port, 1337
set :default_run_options, {:pty => true}


# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
 task :start do ; end
 task :stop do ; end
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
 end

 task :setup_config, roles: :app do
    run "cp -f config/database.example.yml #{release_path}/config/database.yml"
    run "cp -f config/application.example.yml #{release_path}/config/application.yml"
  end
  after "deploy:setup", "deploy:setup_config"

 task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"
end