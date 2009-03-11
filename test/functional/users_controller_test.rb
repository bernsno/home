require File.dirname(__FILE__) + '/../test_helper'

class UsersControllerTest < ActionController::TestCase

  context "GET to :new" do
    setup { get :new }
    should_render_template 'new'
    should_respond_with :success
    should_assign_to :user
  end

  context "POST to :create" do
    setup { post :create, :user => Factory.attributes_for(:inactive_user) }
    should_assign_to :user
    should_change 'User.count', :by => 1
    should_redirect_to 'root_path'
  end
  
  # TODO: Better way to test before_filter?
  context "a logged in user" do
    setup do
      fake_login
    end

    context "GET to :new" do
      setup { get :new }
      should_set_the_flash_to /log out/
      should_redirect_to "admin_user_url(@current_user)"
      should "assign a return_to" do
        assert session[:return_to]
      end
    end

    context "POST to :create" do
      setup { post :create, :user => Factory.attributes_for(:user) }
      should_set_the_flash_to /log out/
      should_redirect_to "admin_user_url(@current_user)"
      should "assign a return_to" do
        assert session[:return_to]
      end
    end
  end

end