set :stages, %w(staging production)
set :default_stage, 'staging'
require 'capistrano/ext/multistage'

# make sure to create staging.rb and production.rb in :rails_root/config/deploy
# and input the correct users, domains, and ssh ports

##### APPLICATION #####

  ### REPLACE ME ###
  set :application, "domain.com"
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
  after "deploy", "deploy:cleanup"

  desc "Streams the (production|error|access) log."
  task :tail_log, :roles => :app do
    file = ENV['FILE'] || 'production'
    stream "tail -f #{shared_path}/log/#{file}.log"
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

  desc "Copies configuration files into the current release."
  task :copy_config_files do
    run "cp #{shared_path}/config/* #{release_path}/config/"
  end
  after "deploy:update_code", "copy_config_files"

  desc "Symlinks uploaded files into the current release."
  task :copy_symlinks do
    run "ln -nfs #{shared_path}/uploaded_files #{current_path}/public/uploaded_files"
  end
  after "deploy:symlink", "copy_symlinks"

  desc "Creates shared configuration and upload directories and default yml files."
  task :create_shared_config do
    # Create folders
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/uploaded_files"

    # Create database configuration
    unless File.exist?("#{shared_path}/config/database.yml")
      template = File.read(File.dirname(__FILE__) + "/database.yml.example")
      result   = ERB.new(template).result(binding)
      put result, "#{shared_path}/config/database.yml"
      puts "Please edit database.yml to set up the database."
    else
      puts "The database.yml file already exists."
    end
    
    # Create application configuration
    unless File.exist?("#{shared_path}/config/application.yml")
      template = File.read(File.dirname(__FILE__) + "/application.yml.example")
      result   = ERB.new(template).result(binding)
      put result, "#{shared_path}/config/application.yml"
      puts "Please edit application.yml to set up the app configuration."
    else
      puts "The application.yml file already exists."
    end
  end
  after "deploy:setup", "create_shared_config"

##### MAC OS X SSH SETTINGS #####
  on :start do
    `ssh-add`
  end