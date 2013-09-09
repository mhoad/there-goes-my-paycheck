require 'capistrano/ext/multistage'
 
set :application, "there-goes-my-paycheck"
set :scm, :git
set :repository,  "git@github.com:mhoad/there-goes-my-paycheck.git"
set :branch, "deployment"
set :scm_passphrase, ""
set :use_sudo, true
 
set :ssh_options, {:forward_agent => true, keys: ['~/.vagrant.d/insecure_private_key']}
set :default_run_options, {:pty => true}
set :stages, ["vagrant"]
set :default_stage, "vagrant"

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end