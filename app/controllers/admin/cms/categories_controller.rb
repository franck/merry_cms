class Admin::Cms::CategoriesController < ApplicationController
  unloadable
  
  layout "admin"
  
  before_filter :set_language_codes
  access_control do
    allow "admin"
    allow "publisher-in-chief"
  end
  
  def index
    root = Category.root
    @categories = root.self_and_descendants unless root.nil?
  end
    
  def new
    @category = Category.new
    set_translated_languages(@category)
  end
  
  def create
    
    current_locale = I18n.locale
    I18n.locale = params[:language]
    
    @category = Category.new(params[:category])
    
    set_translated_languages(@category)
    
    if @category.save
      I18n.locale = current_locale
      
      unless params[:category][:parent_id].nil?
        parent = Category.find(params[:category][:parent_id])
        @category.move_to_child_of parent
      end
      
      flash[:notice] = t('categories.flash.category_created')
      redirect_to :action => :index
    else
      I18n.locale = current_locale
      render :new
    end
  end
  
  def edit
    current_locale = I18n.locale
    I18n.locale = params[:language]

    @category = Category.find(params[:id])
    set_current_edition_language(@category)
    set_translated_languages(@category)
    set_not_translated_languages(@category)

    I18n.locale = current_locale
  end
  
  def update
    current_locale = I18n.locale
    I18n.locale = params[:language]
    
    @category = Category.find(params[:id])
    set_current_edition_language(@category)
    set_translated_languages(@category)
    set_not_translated_languages(@category)
    
    if @category.update_attributes(params[:category])
      I18n.locale = current_locale
      
      unless @category.root? && params[:category][:parent_id].nil?
        parent = Category.find(params[:category][:parent_id])
        @category.move_to_child_of parent
      end
      
      flash[:notice] = t('categories.flash.category_updated')
      redirect_to :action => :index
    else
      I18n.locale = current_locale
      render :edit
    end
  end
  
  def destroy
    category = Category.find(params[:id])
    category.destroy
    flash[:notice] = t('categories.flash.category_deleted')
    redirect_to :action => :index
  end
  
  protected
  
  def set_language_codes
    @languages = SiteSetting.language_codes
  end
  
  def set_current_edition_language(category)
    languages = category.translated_languages
    @current_edition_language = if languages.include? I18n.locale
      I18n.locale
    else
      languages.first
    end
  end
  
  def set_translated_languages(category)
    @translated_languages = category.translated_languages
  end
  
  def set_not_translated_languages(category)
    @not_translated_languages = category.not_translated_languages
  end
  
end