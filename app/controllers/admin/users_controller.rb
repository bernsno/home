class Admin::UsersController < Admin::AdminController
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end

  def update
    @user = @current_user

    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to admin_account_url
    else
      render :action => :edit
    end
  end
end