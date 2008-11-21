RAILS_GEM_VERSION = '2.1.2' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  config.gem 'ryanb-acts-as-list', :lib => 'acts_as_list', :source => 'http://gems.github.com'
  config.gem 'thoughtbot-shoulda', :lib => 'shoulda/rails', :source => "http://gems.github.com" 
  config.gem 'thoughtbot-factory_girl', :lib => 'factory_girl', :source => "http://gems.github.com" 
  config.gem 'mislav-will_paginate', :lib => 'will_paginate', :source => 'http://gems.github.com'
  config.gem 'rubyist-aasm', :lib => 'aasm', :source => 'http://gems.github.com'
  config.gem "capistrano-ext", :lib => "capistrano" 
  
  config.time_zone = 'UTC'
  config.action_controller.session = {
    :session_key => '_eden_session',
    :secret      => '59d6fa68dc511ece8a06664bfd084f88e88d61eec92b2dd2f78964de6e19f1ac405eb7a2b09ce75a0bc48ca4bd72b06fa84f69ab357b75a53dcc290611802ad7'
  }

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with "rake db:sessions:create")
  # config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector
end
