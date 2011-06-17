require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  
  setup :activate_authlogic

  context "on create user with a role" do
    setup do
      login_as("admin")
      post :create, { 
        :user => { 
          :email => "newuser@test.fr", 
          :password => "mypassword", 
          :password_confirmation => "mypassword"
        },
        :roles => { :name => "admin" }
      }
    end
    
    should_respond_with :redirect
    should_set_the_flash_to /Utilisateur ajouté dans la base/    
  end  

end