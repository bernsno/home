class Notifier < ActionMailer::Base
  default_url_options[:host] = Settings.site_host
  
  def password_reset_instructions(user)
    subject       "Your [#{Settings.site_name}] password reset instructions"
    from          "#{Settings.site_name} <noreply@#{Settings.site_host}>"
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end
  
  def activation_instructions(user)
    subject       "Your [#{Settings.site_name}] account activation instructions"
    from          "#{Settings.site_name} <noreply@#{Settings.site_host}>"
    recipients    user.email
    sent_on       Time.now
    body          :account_activation_url => register_url(user.perishable_token)
  end
  
  def activation_confirmation(user)
    subject       "Your [#{Settings.site_name}] account has been activated"
    from          "#{Settings.site_name} <noreply@#{Settings.site_host}>"
    recipients    user.email
    sent_on       Time.now
    body          :root_url => root_url
  end
end