require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  
  setup :activate_authlogic

  context "on GET new" do
    setup do
      get :new
    end
    should_render_a_form
    should_respond_with :success
    should_assign_to :user_session, :class => UserSession
  end
  
  context "on trying to log with valid account" do
    setup do
      user = Factory.create(:user)
      post :create, :user_session => { :email => user.email, :password => "mypassword" }
    end
    should_set_the_flash_to "Vous êtes connecté"
    should_respond_with :redirect
  end
  
  context "on trying to log with not valid account" do
    setup do
      user = Factory.create(:user)
      post :create, :user_session => { :email => user.email, :password => "mypass" }
    end
    should_not_set_the_flash
    should_respond_with :success
    should_render_template :new
    should_render_a_form
  end
  
  context "on trying to logout" do
    setup do
      login_as
      get :destroy
    end
    should_set_the_flash_to "Vous êtes déconnecté"
    should_respond_with :redirect
    should_redirect_to('login_url')
  end
  
  context "on trying to log with a not active account" do
    setup do
      user = Factory.create(:user, :active => false)
      post :create, :user_session => { :email => user.email, :password => "mypass" }
    end
    should_respond_with :success
    should_render_template :new
    should_render_a_form
  end
  
  context "on trying to log with a active account" do
    setup do
      user = Factory.create(:user)
      post :create, :user_session => { :email => user.email, :password => "mypass" }
    end
    #should_respond_with :redirect
  end
  
  
  
end
