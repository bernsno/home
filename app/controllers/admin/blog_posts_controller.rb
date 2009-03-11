class Admin::BlogPostsController < Admin::AdminController
  
  def index
    @blog_posts = BlogPost.by_publish_date
  end
  
  def new
    @blog_post = BlogPost.new
  end
  
  def edit
    @blog_post = BlogPost.find(params[:id])
  end
  
  def create
    @blog_post = BlogPost.new(params[:blog_post])
    respond_to do |format|
      if @blog_post.save
        flash[:notice] = "Blog post created"
        format.html { redirect_to admin_blog_posts_path }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def update
    @blog_post = BlogPost.find(params[:id])
    respond_to do |format|
      if @blog_post.update_attributes(params[:blog_post])
        flash[:notice] = "Blog post updated"
        format.html { redirect_to admin_blog_posts_path }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @blog_post = BlogPost.find(params[:id])
    @blog_post.destroy
    redirect_to admin_blog_posts_path
  end
  
end