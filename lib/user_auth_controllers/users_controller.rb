class UsersController < ApplicationController
  unloadable
  
  layout "home"
  
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])

    if @user.save_without_session_maintenance
      @user.deliver_activation_instructions!
      flash[:notice] = t('authlogic.flash.account_created')
      redirect_to root_url
    else
      render :action => :new
    end
  end

  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end

  def update
    @user = @current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = t('authlogic.flash.user_updated')
      redirect_to root_url
    else
      render :action => :edit
    end
  end

  protected
  
  def get_resumes
    @resumes = current_user.resumes.find(:all, :conditions => "state = 'active'") unless current_user.nil?
  end
  
  def get_personal_info
    if current_user.personal_info.nil?
      @personal_info = PersonalInfo.new
    else
      @personal_info = current_user.personal_info
    end
  end

end
