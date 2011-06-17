ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require "authlogic/test_case"

class ActiveSupport::TestCase
  
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false

  #fixtures :all
  
  def login_as(role = nil)
    user = Factory.create(:user)
    user.has_role!(role)
    UserSession.create(user)
  end

end
