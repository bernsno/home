class BlogPostsController < ApplicationController
	
	def index
		@blog_posts = BlogPost.by_publish_date.paginate :page => params[:page]
		respond_to do |format|
			format.html
			format.rss
		end
	end
	
	def show
		@blog_post = BlogPost.find(params[:id])
	end
	
end