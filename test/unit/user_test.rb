require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase

  # MASS ASSIGNMENT
  should_protect_attributes :active

  # AUTHLOGIC
  should_be_authentic

  # VALIDATIONS
  context "a user" do
    setup do
      @user = users(:admin)
    end
    
    # TODO: allow for allow_blank...
    # should_require_unique_attributes :openid_identifier
  end
  
  # ASSOCIATIONS
  
  # NAMED SCOPES
  should_have_named_scope :active, :conditions => { :active => true }
  should_have_named_scope :inactive, :conditions => { :active => false }
  should_have_named_scope :by_created_at, :order => "created_at DESC"

end