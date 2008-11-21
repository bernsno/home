set :stages, %w(staging production)
set :default_stage, 'staging'
require 'capistrano/ext/multistage'

# make sure to create staging.rb and production.rb in :rails_root/config/deploy
# and input the correct users, domains, and ssh ports

##### APPLICATION #####

  ### REPLACE ME ###
  set :application, "domain.com"
  
  ### REPLACE ME ###
  set :repository,  "github.repository"

##### SOURCE CONTROL #####
  set :scm, "git"
  set :branch, "master"
  set :git_enable_submodules, 1
  # credentials are handled by public keys

##### SERVER #####
  set :rails_env, 'production'
  set :use_sudo, false
  # credentials are handled by public keys

##### DEPLOYMENT #####
  set(:deploy_to) { "/home/#{user}/public_html/#{application}" }
  set :deploy_via, :remote_cache

  # domain (domain set in stage files)
  role(:app)  { domain }
  role(:web)  { domain }
  role(:db)   { domain }

  # ssh options (port set in stage files)
  ssh_options[:forward_agent] = true
  # forwards public keys to verify credentials
  default_run_options[:pty] = true

##### TASKS #####
  task :tail_log, :roles => :app do
    stream "tail -f #{shared_path}/log/production.log"
  end

  # Redefine deploy task for use with Passenger
  namespace :deploy do
    desc "Restart Passenger based Application"
    task :restart, :roles => :app do
      run "touch #{current_path}/tmp/restart.txt"
    end
  
    [:start, :stop].each do |t|
      desc "#{t} task is a no-op with mod_rails"
      task t, :roles => :app do; end
    end
  end

  # Copy any config files into the production directories
  desc "Copy config files"
  task :copy_config_files do
    run "cp #{shared_path}/config/* #{release_path}/config/"
  end
  after "deploy:update_code", "copy_config_files"

  # Symlink any uploaded files
  task :copy_symlinks do
    run "ln -nfs #{shared_path}/uploaded_files #{current_path}/public/uploaded_files"
  end
  after "deploy:symlink", "copy_symlinks"

  # 
  desc "Create shared config and uploaded_files directories and a default database.yml."
  task :create_shared_config do
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/uploaded_files"

    template = File.read(File.dirname(__FILE__) + "/database.yml.example")
    result   = ERB.new(template).result(binding)
    put result, "#{shared_path}/config/database.yml"
    puts "Please edit database.yml in the shared directory."
  end
  after "deploy:setup", "create_shared_config"

  ##### MAC OS X SSH SETTINGS #####
  on :start do
    `ssh-add`
  end