class UserSessionsController < ApplicationController
  unloadable
  
  layout "home"
  
  before_filter :set_page_title
  before_filter :set_user_instance, :only => [:new, :create]
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = t('authlogic.flash.logged_in')
      redirect_to account_url
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = t('authlogic.flash.logged_out')
    redirect_to login_url
  end

  private
  
  def set_page_title
    set_meta_tags :title => t('authlogic.login_page_title'),
                  :reverse => true
  end
  
  def set_user_instance
    # for signin in login page
    @user = User.new
  end

end
