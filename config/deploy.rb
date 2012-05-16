require 'rvm/capistrano'
require 'bundler/capistrano'
#default_run_options[:shell] = '/bin/bash'
default_run_options[:pty] = true
set :application, "diaryonline"
#set :repository,  "git@github.com:windy/diary.git"
set :repository,  "git://github.com/windy/diary.git"
set :user, "ruby"
set :use_sudo, false

set :rvm_ruby_string, '1.9.3-p194'
set :rvm_type, :system
set :keep_releases, 5

set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "thesourcecodes.net"                          # Your HTTP server, Apache/etc
role :app, "thesourcecodes.net"                          # This may be the same as your `Web` server
role :db,  "thesourcecodes.net", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"
#
set :deploy_to, "/home/ruby/app"

set :shared_database_path, "/home/ruby/app/shared/databases"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end

namespace :sqlite3 do
  desc "Generate a database configuration file"
  task :build_configuration, :roles => :db do
    db_options = {
      "adapter"  => "sqlite3",
      "database" => "#{shared_database_path}/production.sqlite3"
    }
    config_options = {"production" => db_options}.to_yaml
    put config_options, "#{shared_database_path}/sqlite_config.yml"
  end
       
  desc "Links the configuration file"
  task :link_configuration_file, :roles => :db do
    run "ln -nsf #{shared_database_path}/sqlite_config.yml #{current_path}/config/database.yml"
  end
           
  desc "Make a shared database folder"
  task :make_shared_folder, :roles => :db do
    run "mkdir -p #{shared_database_path}"
  end

  desc "Backup sqlite database"
  task :backup_database, :roles=> :db do
    run "cp #{shared_database_path}/production.sqlite3 #{shared_database_path}/production.sqlite3.bak"
  end
end

after "deploy:setup", "sqlite3:make_shared_folder"
after "deploy:setup", "sqlite3:build_configuration"

before "deploy:migrate", "sqlite3:link_configuration_file"
before "deploy:migrate", "sqlite3:backup_database"
after "deploy:update", "sqlite3:link_configuration_file"
