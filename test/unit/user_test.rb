require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase

  # MASS ASSIGNMENT
  should_allow_mass_assignment_of :email, :password, :password_confirmation, :openid_identifier
  should_not_allow_mass_assignment_of :active

  # VALIDATIONS
  # TODO: test normalize openid
  
  context "a user with an openid" do
    setup do
      @user_1 = Factory(:user, :openid_identifier => "test.myopenid.com")
      @user_2 = Factory(:user)
    end
    
    should "require a unique openid" do
      @user_2.openid_identifier = "test.myopenid.com"
      @user_2.valid?
      assert @user_2.errors[:openid_identifier].include?('has already been taken')
    end
    
    should "allow for a blank openid" do
      @user_1.openid_identifier = ''
      assert @user_1.save
    end
    
  end

  # AUTHLOGIC
  should_be_authentic

  # INSTANCE METHODS
  context "a user who has just signed up" do
    setup do
      @user_params = { :user => Factory.attributes_for(:inactive_user) }
      @user = User.new
      @user.signup!(@user_params)
    end
    
    should "have no credentials" do
      assert @user.has_no_credentials?
    end
    
    should "not be active" do
      assert !@user.active?
    end
    
  end
  
  context "a user who has just activated" do
    setup do
      @user = Factory(:inactive_user)
      @user_params = { :user => Factory.attributes_for(:user_activating) }
      @user.activate!(@user_params)
    end
    
    should "have credentials" do
      assert !@user.has_no_credentials?
    end
    
    should "be active" do
      assert @user.active?
    end
    
  end
  
  # ASSOCIATIONS
  
  # NAMED SCOPES
  should_have_named_scope :active, :conditions => { :active => true }
  should_have_named_scope :inactive, :conditions => { :active => false }
  should_have_named_scope :by_created_at, :order => "created_at DESC"

end