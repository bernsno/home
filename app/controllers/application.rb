class ApplicationController < ActionController::Base
  include HoptoadNotifier::Catcher
  
  helper :all
  protect_from_forgery # :secret => '68dcc5f07e6c3e158901ed597b28ddd6'
  filter_parameter_logging :password
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  protected

  def record_not_found
    render :file => File.join(RAILS_ROOT, 'public', '404.html'), :status => 404
  end
end