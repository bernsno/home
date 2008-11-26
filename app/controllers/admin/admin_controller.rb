class Admin::AdminController < ApplicationController
  before_filter :require_user
  
  # requires a login
  # layout "admin"
end