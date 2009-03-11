require File.dirname(__FILE__) + '/../test_helper'

class BlogPostsControllerTest < ActionController::TestCase
  setup :create_a_valid_blog_post
  
  context 'GET to :index' do
    setup { get :index }
    should_respond_with :success
    should_assign_to :blog_posts
  end

  context "GET to :show" do
    setup { get :show, :id => @blog_post }
    should_respond_with :success
    should_render_template :show
  end
  
private

  def create_a_valid_blog_post
    @blog_post = Factory(:blog_post)
  end
  
end