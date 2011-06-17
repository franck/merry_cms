require 'test_helper'

class PasswordResetsControllerTest < ActionController::TestCase
  
  setup :activate_authlogic

  context "on GET :new" do
    setup do
      get :new
    end
    should_render_template :new
    should_respond_with :success
  end
  
  context "on GET :new with logged in user" do
    setup do
      login_as(:user)
      get :new
    end
    #should_respond_with :redirect
    #should_set_the_flash_to /bla/
  end
  
  
  context "on POST :create" do
    setup do
      user = Factory.build(:user, :crypted_password => nil)
      user.save_without_session_maintenance
      post :create, :email => user.email
    end
    should_set_the_flash_to /Des instructions pour modifier votre mot de passe vous ont été envoyé par email/
    should_redirect_to "root_url"
    
    #should "send a email with instruction" do
    #  assert_sent_email do |email|
    #    email.to.include?(user.email)
    #  end
    #end
  end
  
  context "on POST :create with email not existing" do
    setup do
      user = Factory.build(:user, :crypted_password => nil)
      user.save_without_session_maintenance
      
      post :create, :email => "no_one@test.fr"
    end
    should_set_the_flash_to "Aucun utilisateur n'a été trouvé avec cette adresse"
    should_respond_with :redirect
  end
  
  context "on GET :edit" do
    setup do
      user = Factory.create(:user)
      get :edit, :id => user.perishable_token
    end
    #should_render_template :edit
    #should_respond_with :success
  end
  
  context "on POST :update with valid password" do
    setup do
      user = Factory.build(:user, :crypted_password => nil)
      user.save_without_session_maintenance
      #UserSession.destroy(user)
      post :update, :id => user.perishable_token, :user => { :password => "mynewpassword", :password_confirmation => "mynewpassword"}
    end
    should_respond_with :redirect
    should_set_the_flash_to /Mot de passe mis à jour avec succès/
  end
  
  context "on POST :update with not valid password" do
    setup do
      user = Factory.build(:user, :crypted_password => nil)
      user.save_without_session_maintenance
      
      post :update, :id => user.perishable_token, :user => { :password => "mynewpassword", :password_confirmation => "bla"}
    end
    should_respond_with :success
    should_render_template :edit
  end

  context "on GET :edit with unvalid perishable token" do
    setup do
      get :edit, :id => "11111111111"
    end
    should_respond_with :redirect
    should_set_the_flash_to /pas pu retrouver votre compte/
  end
  
  

end
