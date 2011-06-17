class ApplicationController < ActionController::Base
	helper :all
	
  #protect_from_forgery
	
	before_filter :current_user, :set_site_title, :site_locales, :locale
	
	rescue_from Acl9::AccessDenied, :with => :access_denied
	
	filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user
  
  include SortableTable::App::Controllers::ApplicationController
	
	def site_locales
    @site_locales = SiteSetting.language_codes
  end
	  	
	def logged_in?
	  false
  end
  
  def permit?(role=nil)
    return false if @current_user.nil?
    unless role.nil?
      return @current_user.has_roles?(role)
    end
    return true
  end
  helper_method :permit?
    
  private
  
  # use named routes in public side of the site
  def locale
    @locale = I18n.locale
  end
  
  def set_site_title
    @site = SiteSetting.find(:first).title
  end
    
  def access_denied
    flash[:notice] = t('authlogic.flash.access_denied')
    redirect_back_or_default root_url
  end  
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
    
  def require_user
    unless current_user
      store_location
      flash[:notice] = t('authlogic.flash.require_user')
      redirect_to login_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = t('authlogic.flash.require_no_user')
      redirect_to root_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

end