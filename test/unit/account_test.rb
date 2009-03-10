require File.dirname(__FILE__) + '/../test_helper'

class AccountTest < ActiveSupport::TestCase

  # VALIDATIONS
  should_validate_presence_of :subdomain

  should_allow_values_for :subdomain, "good", "bad"
  should_not_allow_values_for :subdomain, "...", "/", "!()", :message => 'The subdomain can only contain alphanumeric characters and dashes.'
  should_not_allow_values_for :subdomain, "www", :message => "That subdomain is reserved and unavailable."

  context "an account" do
    setup { @account = Factory(:account, :subdomain => "UPPERCASE") }
    
    should_validate_uniqueness_of :subdomain, :case_sensitive => false
    
    should "downcase the subdomain" do
      assert_equal @account.subdomain, "uppercase"
    end
    
  end

end