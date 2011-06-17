class User < ActiveRecord::Base
    
  # acl9
  acts_as_authorization_subject

  attr_accessible :email, :password, :password_confirmation, :role_attributes

  acts_as_authentic do |c|
    c.login_field = :email
    c.logged_in_timeout = 2.weeks
    
    c.validate_login_field(false)
    
    c.validates_length_of_email_field_options = {
      :within => 6..100,
      :message => I18n.t('authlogic.error_messages.email_length') 
    }
    c.validates_format_of_email_field_options = {
      :with => Authlogic::Regex.email,
      :message => I18n.t('authlogic.error_messages.email_format')
    }
    c.validates_uniqueness_of_email_field_options = {
      :message => I18n.t('authlogic.error_messages.email_uniqueness')
    }
    c.validates_length_of_password_field_options = { 
      :minimum => 4, 
      :on => :update, 
      :if => :has_no_credentials?,
      :message => I18n.t('authlogic.error_messages.password_length')
    }
    c.validates_length_of_password_confirmation_field_options = { 
      :minimum => 4,
      :on => :update, 
      :if => :has_no_credentials?,
      :message => I18n.t('authlogic.error_messages.password_confirmation_length')
    }
    c.validates_confirmation_of_password_field_options = {
      :minimum => 4, 
      :if => :require_password?,
      :message => I18n.t('authlogic.error_messages.confirmation_of_password_field')
    }
  end

  def has_no_credentials?
    self.crypted_password.blank?
  end

  def deliver_password_reset_instructions!
    reset_perishable_token! 
    Notifier.deliver_password_reset_instructions(self)
  end

  def signup!(params)
    self.email = params[:user][:email]
    save_without_session_maintenance
  end

  def active?
    active
  end

  def activate
    self.active = true
  end

  def desactivate
    self.active = false
  end

  def desactivate!
    self.active = false
    save
  end

  def activate!(params)
    self.active = true
    self.password = params[:user][:password]
    self.password_confirmation = params[:user][:password_confirmation]
    save
  end

  def self.filter(per_page="10", page=1, filter="", status="", order="")    
    options = { :per_page => per_page, :page => page }
  
    role_filter = Role.filter(filter)

    find :all do
      paginate options

      all do
        active == status
        any do
          email =~ "%#{filter}%"
          roles.name =~ "%#{role_filter}%"
        end  
      end
      order_by order
    end    
  end

  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.deliver_activation_instructions(self)
  end

  def deliver_activation_confirmation!
    reset_perishable_token!
    Notifier.deliver_activation_confirmation(self)
  end

  def role_attributes=(role_attributes)
    role_attributes.each do |role|
      self.has_role!(role)
    end
  end

  def last_admin?
    if self.has_role?("admin") && User.find_with_role("admin").size == 1
      true
    else
      false
    end
  end

  def self.find_with_role(role)
    find :all do
      roles.name =~ "%#{role}%"
    end
  end

  def allowed?(action)
    true
  end
  
end