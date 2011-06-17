class ActivationsController < ApplicationController
  unloadable
  
  layout "home"
  
  before_filter :require_no_user, :only => [:new, :create]
  
  #rescue_from Exception, :with => :token_expired

  def new
    @user = User.find_using_perishable_token(params[:activation_code], 1.week)
    raise Exception if @user.active?
  end
  
  def create
    @user = User.find(params[:id])

    raise Exception if @user.active?

    if @user.activate!(params)
      @user.deliver_activation_confirmation!
      flash[:notice] = t('authlogic.flash.account_activated')
      redirect_to account_url
    else
      render :action => :new
    end
  end

  def token_expired
    flash[:notice] = t("authlogic.flash.token_expired")
    redirect_to(root_url)
  end

end
