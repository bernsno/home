class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :openid_identifier
  
  # AUTHLOGIC
  acts_as_authentic :login_field_validation_options => { :if => :openid_identifier_blank? },
                    :password_field_validation_options => { :if => :openid_identifier_blank? },
                    :password_field_validates_length_of_options => { :on => :update, :if => :has_no_credentials? }
  
  # VALIDATIONS
  validate :normalize_openid_identifier
  validates_uniqueness_of :openid_identifier, :allow_blank => true
  
  # NAMED SCOPES
  named_scope :active, :conditions => { :active => true }
  named_scope :inactive, :conditions => { :active => false }
  named_scope :by_created_at, :order => "created_at DESC"
  
  # CALLBACKS
  after_create :deliver_activation_instructions!
  
  # User creation/activation
  def signup!(params)
    self.email = params[:user][:email]
    save
  end
  
  def activate!(params)
    self.active = true
    self.password = params[:user][:password]
    self.password_confirmation = params[:user][:password_confirmation]
    self.openid_identifier = params[:user][:openid_identifier]
    save
  end
  
  # Conditionals for authlogic configuration
  def openid_identifier_blank?
    self.openid_identifier.blank?
  end
  
  def has_no_credentials?
    self.crypted_password.blank? && openid_identifier_blank?
  end
  
  # Email notifications
  def deliver_perishable_email!(email)
    reset_perishable_token!
    Notifier.send("deliver_#{email}".to_sym, self)
  end
  
  def deliver_activation_instructions!
    self.deliver_perishable_email!(:activation_instructions)
  end
  
  # Helper methods
  def active?
    active == true
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