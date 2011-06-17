class Notifier < ActionMailer::Base
  
  layout 'notifier'
  
  default_url_options[:host] = APP_CONFIG[:domain]

  def password_reset_instructions(user)
    subject       I18n.t('authlogic.notifier.password_reset_instructions')
    from          APP_CONFIG[:email]
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
    content_type  "text/html"
  end
  
  def activation_instructions(user)
    subject       I18n.t('authlogic.notifier.activation_instructions')
    from          APP_CONFIG[:email]
    recipients    user.email
    sent_on       Time.now
    body          :account_activation_url => url_for(:controller => "activations", :action => "new", :activation_code => user.perishable_token)
    content_type  "text/html"
  end
  
  def activation_confirmation(user)
    subject       I18n.t('authlogic.notifier.activation_confirmation')
    from          APP_CONFIG[:email]
    recipients    user.email
    sent_on       Time.now
    body          :root_url => root_url
    content_type  "text/html"
  end
    
end