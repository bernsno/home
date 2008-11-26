namespace :eden do
  task :set_project_origin do
    `git remote add origin #{ENV['REPO']}`
    `git push origin master`
    `git fetch origin`
    `git checkout origin/master`
    `git branch --track -f master origin/master`
    `git checkout master`
  end
  
  task :set_session_variables do
    require 'erb'
    
    @secret = ActiveSupport::SecureRandom.hex(130)
    @name   = ENV['NAME']
    
    puts @secret
    
    result = ERB.new(File.read(File.dirname(__FILE__)+'/../templates/session.rb.erb')).result(binding)
    File.open(File.dirname(__FILE__)+'/../../config/session.rb', 'w') do |f|
      f << result
    end
  end
  
  task :create_default_admin_user => :environment do
    User.create!(:email => "admin@thesite.com", :password => "changeme", :password_confirmation => "changeme")
    puts "Default admin user created."
  end
end