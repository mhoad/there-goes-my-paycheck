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
end