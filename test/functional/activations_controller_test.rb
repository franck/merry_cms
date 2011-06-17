require 'test_helper'

class ActivationsControllerTest < ActionController::TestCase

  context "on GET :new with a valid user" do
    setup do
      #user = Factory.build(:user, :active => false)
      #user.save_without_session_maintenance
      user = User.new(:email => "franck@test.fr")
      user.save_without_session_maintenance
      get :new, :activation_code => user.perishable_token
    end
    should_assign_to :user
    should_respond_with :success
    should_render_template :new
    should_render_a_form
  end
  
  # IMPOSSIBLE A TESTER : une exception ne peut etre testé correctement
  context "on GET :new with a not valid user" do
    setup do
      user = Factory.create(:user, :active => true)
      assert_raise ("Erreur") {
        get :new, :activation_code => user.perishable_token
      }
    end
    #should_respond_with :redirect
    #should_set_the_flash_to /votre token doit être faux ou a expiré/
  end  

end
