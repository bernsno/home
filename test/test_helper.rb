ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require 'authlogic/testing/test_unit_helpers'

class Test::Unit::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  fixtures :all
end

class ActionController::TestCase

  def fake_login(user_opts = {})
    @current_user = Factory(:user, user_opts)
    set_session_for(@current_user)
  end
  
end