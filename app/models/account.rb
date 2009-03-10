class Account < ActiveRecord::Base
  
  # CALLBACKS
  before_validation :downcase_subdomain
  
  # VALIDATIONS
  validates_presence_of :subdomain
  validates_format_of :subdomain, :with => /^[A-Za-z0-9-]+$/, :message => 'The subdomain can only contain alphanumeric characters and dashes.', :allow_blank => true
  validates_uniqueness_of :subdomain, :case_sensitive => false, :allow_blank => true
  validates_exclusion_of :subdomain, :in => %w( www ), :message => "That subdomain is reserved and unavailable."

  private
  
  def downcase_subdomain
    self.subdomain.downcase! if attribute_present?("subdomain")
  end
  
end