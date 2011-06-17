class Admin::UsersController < ApplicationController
  unloadable
  
  sortable_attributes :email
  
  layout "admin"
  
  access_control do
    allow "admin"
  end
  
  def index
    per_page = params[:per_page] || "10"
    if params[:active] == "1"
      active = false 
    else
      active = true
    end
    @users = User.filter(per_page, params[:page], params[:filter], active, sort_order(:default => "ascending"))
  end
  
  def new
    @user = User.new
    @roles = Role::ROLES
  end
  
  def create
    @user = User.new(
      :email => params[:user][:email],
      :password => params[:user][:password],
      :password_confirmation => params[:user][:password_confirmation],
      :active => true
    )
    @user.activate
    @roles = Role::ROLES
    
    roles = params[:roles] || []
    for role in roles
      @user.has_role!(role)
    end
    
    if @user.save_without_session_maintenance
      flash[:notice] = t('users.user_added')
      redirect_to :action => "index"
    else
      render :new
    end
    
  end
  
  
  def edit
    @user = User.find(params[:id])
    @roles = Role::ROLES
  end
  
  def update
    @user = User.find(params[:id])
    @roles = Role::ROLES
    
    if @user.last_admin?
      @user.has_no_roles!
      @user.has_role!("admin")
    else
      @user.has_no_roles!
    end
    
    roles = params[:roles] || []
    for role in roles
      @user.has_role!(role)
    end
    
    if @user.update_attributes(params[:user])
      flash[:notice] = t('users.user_updated')
      redirect_to :action => "index"
    else
      render :edit
    end
  end
  
  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:notice] = t('users.user_deleted')
    redirect_to :action => "index"
  end
  
  def activate
    user = User.find(params[:id])
    user.activate
    user.save
    flash[:notice] = t('users.user_activated')
    redirect_to :action => "index"
  end
  
  def desactivate
    user = User.find(params[:id])
    user.desactivate!
    flash[:notice] = t('users.user_desactivated')
    redirect_to :action => "index"
  end
  
end


