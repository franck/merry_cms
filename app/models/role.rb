class Role < ActiveRecord::Base
  acts_as_authorization_role
  
  def self.filter(filter)
    self.list_of_roles.each do |role|
      return role if I18n.t("roles.#{role}") =~ /#{filter}/
    end
  end
  
  def self.list_of_roles
    self.find(:all).map{|r| r.name }
  end
  
end
