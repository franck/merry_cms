class PasswordResetsController < ApplicationController
  unloadable
  
  layout "account"

  before_filter :require_no_user
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]
  
  def index
    redirect_to :action => :new
  end
  
  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      flash[:notice] = t('authlogic.flash.reset_password_instructions_emailed')
      redirect_to root_url
    else
      flash[:notice] = t('authlogic.flash.no_user_with_that_email')
      redirect_to :action => :new
    end
  end
  
  def edit
    render
  end

  def update
    
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      flash[:notice] = t('authlogic.flash.password_not_reset')
      redirect_to root_url
    else
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation]
      if @user.save
        flash[:notice] = t('authlogic.flash.password_updated')
        redirect_to login_url
      else
        render :action => :edit
      end
    end
  end

  private
  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    
    unless @user
      flash[:notice] = t('authlogic.flash.could_not_locate_account')
      redirect_to root_url
    end
  end
  


end
