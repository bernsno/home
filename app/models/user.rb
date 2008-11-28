class User < ActiveRecord::Base
  # TODO: Set proper attr_accessible
  # attr_accessible :email, :password, :password_confirmation, :openid_identifier
  
  acts_as_authentic :login_field_validation_options => { :if => :openid_identifier_blank? },
                    :password_field_validation_options => { :if => :openid_identifier_blank? },
                    :password_field_validates_presence_of_options => { :on => :update, :if => :has_no_credentials? }
  
  validate :normalize_openid_identifier
  validates_uniqueness_of :openid_identifier, :allow_blank => true
  
  named_scope :active, :conditions => { :active => true }, :order => "created_at DESC"
  
  # User creation/activation
  def signup!(params)
    self.email = params[:user][:email]
  end
  
  def activate!(params)
    self.active = true
    self.password = params[:user][:password]
    self.password_confirmation = params[:user][:password_confirmation]
    self.openid_identifier = params[:user][:openid_identifier]
  end
  
  # Conditionals for authlogic configuration
  def openid_identifier_blank?
    openid_identifier.blank?
  end
  
  def has_no_credentials?
    self.crypted_password.blank? && self.openid_identifier.blank?
  end
  
  # Email notifications
  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
  
  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.deliver_activation_instructions(self)
  end
  
  def deliver_activation_confirmation!
    reset_perishable_token!
    Notifier.deliver_activation_confirmation(self)
  end
  
  # Helper methods
  def active?
    active
  end
  
  private

    def normalize_openid_identifier
      begin
        self.openid_identifier = OpenIdAuthentication.normalize_url(openid_identifier) if !openid_identifier.blank?
      rescue OpenIdAuthentication::InvalidOpenId => e
        errors.add(:openid_identifier, e.message)
      end
    end
end