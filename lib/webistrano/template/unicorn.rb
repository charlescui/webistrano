module Webistrano
  module Template
    module Unicorn

      CONFIG = Webistrano::Template::Rails::CONFIG.dup.merge({
                                                                 :unicorn_workers => '8',
                                                                 :unicorn_workers_timeout => '30',
                                                                 :unicorn_user => 'www',
                                                                 :unicorn_group => 'www',
                                                                 :unicorn_bin => 'bundle exec unicorn_rails',
                                                                 :unicorn_socket => '/home/www/rca.webistrano/current/tmp/sockets/unicorn.sock',
                                                                 :unicorn_config => "/home/www/rca.webistrano/current/config/unicorn.rb",
                                                                 :unicorn_pid => '/home/www/rca.webistrano/current/tmp/pids/unicorn.pid'
                                                             }).freeze

      DESC = <<-'EOS'
        Template for use of Unicorn projects irrespective of web server on top.

        Overrides the deploy.restart, deploy.start, and deploy.stop tasks to use
        unicorn signals instead.
      EOS

      TASKS = Webistrano::Template::Base::TASKS + <<-'EOS'

        def unicorn_start_cmd
          "cd #{current_path} && #{unicorn_bin} -c #{unicorn_config} -E #{rails_env} -D"
        end

        def unicorn_stop_cmd
          "kill -QUIT `cat #{unicorn_pid}`"
        end

        def unicorn_restart_cmd
          "kill -USR2 `cat #{unicorn_pid}"
        end
      
        namespace :webistrano do
          namespace :unicorn do
            desc "Start Unicorn directly"
            task :start, :roles => :app, :except => { :no_release => true } do
              as = fetch(:runner, "app")
              invoke_command "#{unicorn_start_cmd}", :via => run_method, :as => as
            end
            
            desc "Stop Unicorn directly"
            task :stop, :roles => :app, :except => { :no_release => true } do
              as = fetch(:runner, "app")
              invoke_command "#{unicorn_stop_cmd}", :via => run_method, :as => as
            end
            
            desc "Restart Unicorn app directly"
            task :restart, :roles => :app, :except => { :no_release => true } do
              as = fetch(:runner, "app")
              invoke_command "#{unicorn_restart_cmd}", :via => run_method, :as => as
            end
          end
        end
        
        namespace :deploy do
          task :restart, :roles => :app, :except => { :no_release => true } do
            webistrano.unicorn.restart
          end
          
          task :start, :roles => :app, :except => { :no_release => true } do
            webistrano.unicorn.start
          end
          
          task :stop, :roles => :app, :except => { :no_release => true } do
            webistrano.unicorn.stop
          end
        end
      EOS

    end
  end
end