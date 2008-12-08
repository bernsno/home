class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  
  def new
    @user = User.new
  end

  def create
    # Only allow users to specify their e-mail at this stage.
    # Don't want them to set pw or openid yet
    @user = User.new

    if @user.signup!(params)
      flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
      redirect_to root_path
    else
      render :action => :new
    end
  end

end