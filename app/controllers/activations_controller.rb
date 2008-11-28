class ActivationsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  
  def new
    # TODO: Friendly message for if token is expired? i.e. never got your activation code?
    @user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise ActiveRecord::RecordNotFound)
    # TODO: Do I need this or something like it?
    raise ActiveRecord::RecordNotFound if @user.active?
  end

  def create
    @user = User.find(params[:id])
    
    # For security reasons, don't allow someone who
    # has already activated to re-activate
    # TODO: Cleanup comment and raise better exception
    raise ActiveRecord::RecordNotFound if @user.active?
    @user.activate!(params)

    if @user.save
      @user.deliver_activation_confirmation!
      redirect_to admin_account_url
    else
      render :action => :new
    end
  end

end