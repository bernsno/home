require File.dirname(__FILE__) + '/../test_helper'

class BlogPostTest < ActiveSupport::TestCase

  # VALIDATIONS
	should_validate_presence_of :title, :body, :intro

	# ASSOCATIONS

	# NAMED SCOPES
	should_have_named_scope :publishable, :conditions => { :publish => true }
	should_have_named_scope :by_publish_date, :order => "publish_date DESC"

	# INSTANCE METHODS
	context "a valid blog post" do
		setup { @blog_post = Factory(:blog_post) }
		
		should "parameterize title" do
			assert_equal @blog_post.to_param, "#{@blog_post.id}-#{@blog_post.title.parameterize}"
		end
	end

	# WILL PAGINATE
	should_have_per_page 10
	
	# PAPERCLIP
	should_have_attached_file :image
	should_validate_attachment_size :image, :in => 1..BlogPost::UPLOAD_LIMIT.megabytes

end