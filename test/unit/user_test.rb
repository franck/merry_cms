require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should_not_allow_mass_assignment_of :active?
  
  context "When user is active, active?" do
    setup do
      @user = Factory.create(:user)
    end

    should "return true" do
      assert_equal @user.active?, true
    end
  end
  
  context "when user is not active, active?" do
    setup do
      @user = Factory.create(:user, :active => false)
    end

    should "return false" do
      assert_equal @user.active?, false
    end
  end
  
  context "when a user is not active" do
    setup do
      @user = Factory.create(:user, :active => false)
      @user.activate!( :user => { :password => "mypassword", :password_confirmation => "mypassword" } )
    end

    should "activate it" do
      assert @user.active?
    end
  end

end
