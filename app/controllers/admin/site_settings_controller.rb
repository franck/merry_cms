class Admin::SiteSettingsController < ApplicationController
  unloadable
  
  layout "admin"
  
  access_control do
    allow "admin"
  end
  
  def index
    @site_setting = SiteSetting.find(:first)
  end
  
  def edit
    @languages = Language::LOCALES
    @site_setting = SiteSetting.find(params[:id])
  end
  
  def update
    @site_setting = SiteSetting.find(params[:id])
    @languages = Language::LOCALES
    
    @site_setting.languages.each{|l| l.destroy }
    
    languages = params[:languages] || []
    for language in languages
      @site_setting.languages << Language.create(:code => language)
    end
    
    if @site_setting.update_attributes(params[:site_setting])
      redirect_to_with_right_locale(params[:languages])
    else
      render :edit
    end
  end
  
  private
    
  def redirect_to_with_right_locale(languages)    
    unless languages.nil?
      unless languages.include? I18n.locale
        I18n.default_locale = languages.first
        I18n.locale = languages.first
        I18n.locale = languages.first
      end
    end
    
    flash[:notice] = t('site.flash.site_settings_updated')
    redirect_to :action => "index"
  end
  
  
  
end
