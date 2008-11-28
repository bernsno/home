class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  
  def new
    @user = User.new
  end

  def create
    # Only allow users to specify their e-mail at this stage.
    # Don't want them to set pw or openid yet
    @user = User.new
    @user.signup!(params)
    
    # Saving without session maintenance to skip
    # auto-login which can't happen here because
    # the User has not yet been activated
    if @user.save_without_session_maintenance
      @user.deliver_activation_instructions!
      flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
      redirect_to login_path
    else
      render :action => :new
    end
  end

end