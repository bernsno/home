class ActivationsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :load_and_verify_user, :only => [:new, :create]

  def new
    render
  end

  def create
    if @user.activate!(params)
      @user.deliver_perishable_email!(:activation_confirmation)
      flash[:notice] = "Your account has been activated."
      redirect_to account_url
    else
      render :action => :new
    end
  end

  private
  
    def load_and_verify_user
      @user = User.find_using_perishable_token(params[:activation_code], 1.week)
      
      if @user.nil? || @user.active?
        flash[:error] = "We could not locate your account."
        redirect_to root_path and return
      end
    end

end