require File.dirname(__FILE__) + '/../../test_helper'

class Admin::BlogPostsControllerTest < ActionController::TestCase
  setup :fake_login
  setup :create_a_blog_post
  
  context 'GET to :index' do
    setup { get :index }
    should_respond_with :success
    should_assign_to :blog_posts
  end

  context "GET to :new" do
    setup { get :new }
    should_render_template 'new'
    should_respond_with :success
    should_assign_to :blog_post
  end

  context "GET to :edit" do
    setup { get :edit, :id => @blog_post }
    should_render_template :edit
    should_respond_with :success
  end
  
  context "POST to :create" do
    setup { post :create, :blog_post => Factory.attributes_for(:blog_post) }
    should_assign_to :blog_post
    should_change 'BlogPost.count', :by => 1
    should_redirect_to 'admin_blog_posts_path'
  end
  
  context "PUT to :update" do
    setup { put :update, :id => @blog_post, :blog_post => @blog_post.attributes.merge(:title => "New Title") }
    should_assign_to :blog_post
    should_redirect_to "admin_blog_posts_path"
  end
  
  context "DELETE to :destroy" do
    setup do 
      delete :destroy, :id => @blog_post
    end
    should_change "BlogPost.count", :by => -1
    should_redirect_to "admin_blog_posts_path"
  end
  
private

  def create_a_blog_post
    @blog_post = Factory(:blog_post)
  end
  
end