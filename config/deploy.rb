require 'rvm/capistrano'
require "bundler/capistrano"

set :rvm_ruby_string, '1.9.3-p392'
set :rvm_type, :user

default_run_options[:pty] = true 
ssh_options[:forward_agent] = true
ssh_options[:auth_methods] = %w(publickey)
ssh_options[:port] = 27788

set :application, "rca.webistrano"

set :deploy_via, :copy
set :repository, '.'
set :scm, :none

# set :repository, "git@github.com:charlescui/webistrano.git"
# set :scm, :git
# set :deploy_via, :remote_cache
set :scm_username, "zheng.cuizh@gmail.com"
set :keep_releases, 5   # 留下多少个版本的源代码

set :user,      "www"   # 服务器 SSH 用户名

# ----------部署master或devel--------------------
set :branch, "rails_3_upgrade"
set :deploy_to, "/home/www/rca.webistrano/"
role :web, "yiqikan.tv"                          # Your HTTP server, Apache/etc
role :app, "yiqikan.tv"                          # This may be the same as your `Web` server
role :db, "yiqikan.tv", :primary => true
set :use_sudo,  false

# unicorn config
set :rails_env, :production
set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"
set :server_god, "#{current_path}/config/server.god"

namespace :deploy do
  task :start, :roles => :app do
    run "cd #{current_path};bundle exec unicorn_rails -c #{unicorn_config} -E production -D"
  end
  desc "Reload unicorn"
  task :restart, :roles => :app do   
		run "cat #{unicorn_pid};touch #{current_path}/REVISION;sh -c 'kill -USR2 `cat #{unicorn_pid}`'"
  end
  desc "migrate"
  task :migration,:roles => :db do      
    run "cd #{current_path} && bundle exec rake db:migrate RAILS_ENV=production"
  end
  task :precompile,:roles => :app do
    run "cd #{release_path} && bundle exec rake assets:precompile RAILS_ENV=production"
  end
end

after 'deploy:update_code' do
  softlinks = [
    "ln -nfs #{deploy_to}shared/config/unicorn.rb #{release_path}/config/unicorn.rb",
    "ln -nfs #{deploy_to}shared/config/database.yml #{release_path}/config/database.yml",
    "ln -nfs #{deploy_to}shared/config/webistrano_config.rb #{release_path}/config/webistrano_config.rb"
  ]
  run "#{softlinks.join(';')}"
end

after 'deploy' do
  #nothing
end

# after "deploy:update_code", "deploy:migrate"
after "deploy:update_code", "deploy:precompile"

def set_env
  %[export LANG="en_US.UTF-8";]
end
