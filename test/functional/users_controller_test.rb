require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  setup :activate_authlogic

  context "on GET :new" do
    setup do
      get :new
    end
    should_respond_with :success
    should_render_a_form
    should_assign_to :user, :class => User
  end

  context "on POST :create with a new user" do
    setup do
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.deliveries = []
      post :create, :user => { :email => "lily@test.fr" }
    end
    should_set_the_flash_to "Votre compte a été crée. Vérifier votre email afin de suivre la procédure de confirmation."
    should_respond_with :redirect
    should "send an instruction email" do
      assert_sent_email do |email|
        email.subject =~ /Activation Instructions/
        email.from =~ /Connexion Emploi/
        email.to.include?('lily@test.fr')
      end
    end
  end

  context "on POST :create with not valid credentials" do
    setup do      
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.deliveries = []
      post :create, :user => { :email => "franck@test" }
    end
    should_not_set_the_flash
    should_respond_with :success
    should_render_template :new
    should "not send an email" do
      assert_did_not_send_email
    end
  end

  context "on GET :show" do
    setup do
      login_as(:user)
      get :show
    end
    should_assign_to :user, :class => User
    should_render_template :show
  end

  context "on GET :edit" do
    setup do
      login_as(:user)
      get :edit
    end
    should_assign_to :user, :class => User
    should_render_template :edit
    should_render_a_form
  end

  context "on POST :update with valid credentials" do
    setup do
      login_as(:user)
      post :update, :user => { :email => "franck@test.com" }
    end
    should_respond_with :redirect
    should_set_the_flash_to "Données mises à jour"
  end

  context "on POST :update with not valid credentials" do
    setup do
      login_as(:user)
      post :update, :user => { :email => "franck@test" }
    end
    should_respond_with :success
    should_render_template :edit
  end  
  
end