RAILS_GEM_VERSION = '2.2.2' unless defined? RAILS_GEM_VERSION
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  config.load_paths += %W( #{RAILS_ROOT}/app/models/mailers )

  # Gem Plugins
  config.gem 'ryanb-acts-as-list', :lib => 'acts_as_list', :source => 'http://gems.github.com'
  config.gem 'thoughtbot-shoulda', :lib => 'shoulda/rails', :source => 'http://gems.github.com'
  config.gem 'thoughtbot-factory_girl', :lib => 'factory_girl', :source => 'http://gems.github.com'
  config.gem 'thoughtbot-paperclip', :lib => 'paperclip', :source => 'http://gems.github.com'
  config.gem 'mislav-will_paginate', :lib => 'will_paginate', :source => 'http://gems.github.com'
  config.gem 'capistrano-ext', :lib => 'capistrano', :source => 'http://gems.github.com'
  config.gem 'authlogic'
  config.gem 'settingslogic'
  config.gem 'ruby-openid', :lib => 'openid'
  
  # Time zone
  config.time_zone = 'UTC'

  # gem tasks are loaded in the Rakefile

  # Load factories
  config.after_initialize do
    %w(test spec).each do |dir|
      factories = File.join(RAILS_ROOT, dir, 'factories.rb')
      require factories if File.exists?(factories)
      Dir[File.join(RAILS_ROOT, dir, 'factories', '*.rb')].each do |file|
        require file
      end
    end  
  end

  # Session
  # Thanks Blank (http://github.com/giraffesoft/blank/tree/)
  session_config = "#{RAILS_ROOT}/config/session.rb"
  File.exist?(session_config) ? load(session_config) : raise("Session file missing. Please run 'rake eden:session_config'.")
  config.action_controller.session = SESSION_CONFIG
end