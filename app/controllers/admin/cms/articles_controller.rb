class Admin::Cms::ArticlesController < ApplicationController
  unloadable
  
  layout "admin"

  before_filter :set_language_codes, :only => [:index, :new, :show, :edit, :create, :update]
  
  after_filter :store_location, :except => [:publish, :unpublish, :archive, :unarchive]
    
  access_control do
    allow "writer", :except => [:publish, :unpublish, :archive, :unarchive, :destroy]
    allow "publisher"
    allow "publisher-in-chief"
    allow "admin"
  end

  sortable_attributes :created_at, :title, :state
  
  uses_tiny_mce :only => [:new, :create, :edit, :update],
                  :options => {
                  #:language => 'fr',
                  :external_image_list_url => "/admin/assets/list",
                  :theme_advanced_statusbar_location => "bottom",
                  :theme_advanced_resizing => true,
                  :theme => 'advanced',
                  :extended_valid_elements => "iframe[src|width|height|name|aligns|style|scrolling|frameborder]",
                  :theme_advanced_toolbar_location => "top",
                  :theme_advanced_toolbar_align => "left",
                  :theme_advanced_buttons1 => "bold,italic,underline,separator,bullist,numlist,separator,justifyleft,justifycenter,justifyright,justifyfull,separator,outdent,indent,separator,link,unlink,hr,formatselect,pasteword,charmap,code,image,fullscreen",
                  :theme_advanced_buttons2 => "",
                  :theme_advanced_buttons3 => "",
                  :plugins => %w{ fullscreen advimage paste},
                  :paste_auto_cleanup_on_paste => true,
                  :relative_urls => false,
                  :convert_urls => false
                }
  
  def index
    per_page = params[:per_page] || "10"
    @keywords = Article.tag_list
    @articles = Article.filter(per_page, params[:page], params[:filter], params[:state], params[:keyword], params[:category], sort_order(:default => "descending"))
  end
  
  def show
    @article = Article.find(params[:id])
    @docs = AttachedDocument.find(:all, :conditions => "article_id = #{@article.id}")
    set_translated_languages(@article)
    set_not_translated_languages(@article)
  end
  
  def new
    @article = Article.new
    set_translated_languages(@article)
  end
  
  def create
    
    current_locale = I18n.locale
    I18n.locale = params[:language]
        
    @article = Article.new(params[:article])
    
    set_translated_languages(@article)
    
    if @article.save
      I18n.locale = current_locale
      
      flash[:notice] = t('articles.flash.article_created')
      redirect_to :action => "show", :id => @article
    else
      I18n.locale = current_locale
      render :new
    end
  end
  
  def edit
    @article = Article.find(params[:id])
    set_current_edition_language(@article)
    set_translated_languages(@article)
    set_not_translated_languages(@article)
  end
  
  def update
    current_locale = I18n.locale
    I18n.locale = params[:language]
    
    @article = Article.find(params[:id])  
    set_current_edition_language(@article)
    set_translated_languages(@article)
    set_not_translated_languages(@article)
    
    if @article.update_attributes(params[:article])
      I18n.locale = current_locale
      flash[:notice] = t('articles.flash.article_updated')
      redirect_to :action => "show", :id => @article, :language => params[:language]
    else
      I18n.locale = current_locale
      render :edit
    end
  end
  
  def destroy
    article = Article.find(params[:id])
    article.destroy
    flash[:notice] = t('articles.flash.article_deleted')
    redirect_to :action => "index"
  end
  
  def publish
    article = Article.find(params[:id])
    article.publish
    if article.save
      flash[:notice] = t('articles.flash.article_published')
    else
      flash[:error] = t('articles.flash.error')
    end
    redirect_back_or_default admin_cms_articles_url
  end
  
  def unpublish
    article = Article.find(params[:id])
    article.unpublish
    if article.save
      flash[:notice] = t('articles.flash.article_unpublished')
    else
      flash[:error] = t('articles.flash.error')
    end
    redirect_back_or_default admin_cms_articles_url
  end
  
  def archive
    article = Article.find(params[:id])
    article.archive
    if article.save
      flash[:notice] = t('articles.flash.article_archived')
    else
      flash[:error] = t('articles.flash.error')
    end
    redirect_back_or_default admin_cms_articles_url
  end
  
  def unarchive
    article = Article.find(params[:id])
    article.unarchive
    if article.save
      flash[:notice] = t('articles.flash.article_unarchived')
    else
      flash[:error] = t('articles.flash.error')
    end
    redirect_back_or_default admin_cms_articles_url
  end
  
  protected
  
  def set_language_codes
    @languages = SiteSetting.language_codes
  end
  
  def set_current_edition_language(article)
    languages = article.translated_languages
    @current_edition_language = if languages.include? I18n.locale
      I18n.locale
    else
      languages.size == 0 ? I18n.default_locale : languages.first
    end
    puts "LANGUAGES : " + @current_edition_language.to_s
  end
  
  def set_translated_languages(article)
    @translated_languages = article.translated_languages
  end
  
  def set_not_translated_languages(article)
    @not_translated_languages = article.not_translated_languages
  end
  
end