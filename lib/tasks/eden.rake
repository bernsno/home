namespace :eden do
  desc "Switches an Eden's project origin to REPO"
  task :set_project_origin do
    `git remote add origin #{ENV['REPO']}`
    `git push origin master`
    `git fetch origin`
    `git checkout origin/master`
    `git branch --track -f master origin/master`
    `git checkout master`
  end
  
  desc "Creates a session.rb for use with a new Eden project. If you overwrite your current session.rb all sessions will be invalidated."
  task :set_session_variables do
    require 'erb'
    
    @secret = ActiveSupport::SecureRandom.hex(130)
    
    if ENV['NAME']
      @name   = ENV['NAME']
    else
      @name = "REPLACE_ME"
    end

    result = ERB.new(File.read(File.dirname(__FILE__)+'/../templates/session.rb.erb')).result(binding)
    File.open(File.dirname(__FILE__)+'/../../config/session.rb', 'w') do |f|
      f << result
    end
    
    puts ":session_key => _#{@name}_session"
    puts ":secret => #{@secret}"
  end
  
  desc "Sets up a proper .gitignore for a new Eden project."
  task :ignore_files do
    `cp .new_app.gitignore .gitignore`
  end
  
  desc "Creates a default admin user for a new Eden project."
  task :new_user => :environment do
    User.create!(:email => "admin@thesite.com", :password => "changeme", :password_confirmation => "changeme", :active => true)
    puts "Default admin user created."
    puts "email: admin@thesite.com"
    puts "password: changeme"
  end

  desc "Grabs the latest changes from the Eden repository."
  task :update do
    'git fetch eden'
    'git merge eden/master'
  end
end