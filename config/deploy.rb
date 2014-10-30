require 'capistrano/ext/multistage'
set :application, 'emailsender'
set :scm,:git
set :branch, "master"
#set :repository, "git@bitbucket.org:dimomohit/emailsender.git" # set this to your repo
set :user, "root"
set :scm_passphrase, ""
set :use_sudo, false
#set :rails_env, "development"
set :deploy_via, :remote_cache
set :stages, ["staging", "development", "production"]
set :default_stage, "development"
default_run_options[:pty] = true
ssh_options[:forward_agent] = true

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   
