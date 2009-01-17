class Admin::UsersController < Admin::AdminController
  before_filter :require_this_user, :only => [:edit, :update]
  
  def index
    @users = User.active.paginate :page => (params[:page] || 1)
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new

    if @user.signup!(params)
      flash[:notice] = "The account has been created. Tell the new user to check their e-mail for account activation instructions!"
      redirect_to admin_users_path
    else
      render :action => :new
    end
  end

  def edit
    render
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "Profile updated!"
      redirect_to [:admin, @user]
    else
      render :action => :edit
    end
  end
  
  private
  
  def require_this_user
    @user = User.find(params[:id])
    unless current_user == @user
      flash[:notice] = "You cannot access this user's profile."
      redirect_to admin_users_path
    end
  end
end