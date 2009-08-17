set :application, "yoyaku"
set :deploy_to, "/home/deploy/app"

role :app, "74.207.244.236"
role :web, "74.207.244.236"
role :db,  "74.207.244.236", :primary => true

default_run_options[:pty] = true
set :repository,  "git://github.com/spacecow/Testing.git"
set :scm, "git"
set :branch, "master"
set :deploy_via, :remote_cache

set :user, "deploy"
set :admin_runner, "deploy"

namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
  desc "Start Application -- not needed for Passenger"
  task :start, :roles => :app do
    # nothing -- need to override default cap start task when using Passenger
  end
end

