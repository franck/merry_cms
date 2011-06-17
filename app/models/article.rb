#require 'transform.rb'

class Article < ActiveRecord::Base
  
  before_validation :set_permalink
  translates :title, :intro, :content, :permalink
  
  belongs_to :category
  
  has_many :attached_documents

  acts_as_taggable_on :keywords
  
  include AASM
  aasm_column :state
  aasm_initial_state :pending
  aasm_state :pending, :enter => :unset_all
  aasm_state :published, :enter => :set_published_at
  aasm_state :archived, :enter => :set_archived_at
  
  aasm_event :publish do
    transitions :from => :pending, :to => :published
  end
  
  aasm_event :unpublish do
    transitions :from => :published, :to => :pending
  end
  
  aasm_event :archive do
    transitions :from => :pending, :to => :archived
  end
  
  aasm_event :unarchive do
    transitions :from => :archived, :to => :pending
  end
  
  validates_presence_of :title, :message => I18n.t('articles.error_messages.title_cant_be_blank')
  
  def self.filter(per_page="10", page=1, filter="", state_filter="", keyword="", category_filter="", order="")    
    options = { :per_page => per_page, :page => page }
    
    results = find :all do
      all do
        any do
          title =~ "%#{filter}%"
        end
        unless state_filter.blank?
          state == state_filter
        end
        if category_filter.nil? || category_filter.blank?
        elsif category_filter == "nil"
          category.id.nil?
        else
          category.id == Category.find(category_filter).self_and_descendants.map{|c| c.id }          
        end
        
      end
      order_by "articles." + order
    end
    
    unless keyword.blank?
      results.collect!{|a| a if a.keyword_list.include? keyword}.compact!
    end
    
    results.paginate(options)  
  end
  
  def self.tag_list
    self.keyword_counts.sort{|k,y| k.name <=> y.name }
  end
  
  def translated_languages
    self.globalize_translations.map{|translation|translation.locale.to_s unless translation.title.nil? }.compact!
  end
  
  def not_translated_languages
    translated = self.translated_languages
    not_translated = SiteSetting.language_codes - translated
    return not_translated
  end
    
  def intro_with_form(language="fr")
    intro = intro_locale(language)
    intro.gsub!("</textarea>", ERB::Util.h("</textarea>")) unless intro.nil?
    intro
  end  
  
  def content_with_form(language="fr")
    content = content_locale(language)
    content.gsub!("</textarea>", ERB::Util.h("</textarea>")) unless content.nil?
    content
  end  
  
  def self.find_published_tagged_with(tags, options = {})
    conditions = []
    conditions << options[:conditions] if options[:conditions]
    conditions << "published_at IS NOT NULL"
    
    new_options = { :conditions => conditions.join(" AND "), :order => "published_at desc" }
    new_options.update(options)
    
    self.find_tagged_with(tags, new_options)
  end
  
  def self.find_published_in_category(category_permalink)
    results = find :all do
      all do
        state == "published"
        category.permalink == category_permalink
      end
    end
  end
  
  def self.find_all_published
    results = find :all do
      all do
        state == "published"
      end
    end
  end
  
  def self.find_published(object)
    results = find :first do
      all do
        id == object
        state == "published"
      end
    end
  end
  
  def published
    results = self.find :all do
      all do
        state == "published"
      end
    end
  end
  
  protected
  
  def set_published_at
    self.published_at = Time.now
    self.save
  end
  
  def set_archived_at
    self.archived_at = Time.now
    self.save
  end
  
  def unset_all
    self.published_at = nil
    self.archived_at = nil
    self.save
  end
  
  def set_permalink
    if self.permalink.blank? || self.title_changed?
      p = self.title.to_url
      
      articles = ArticleTranslation.find :all do
        permalink =~ "#{p}%"
      end
      
      articles.reject!{|a| a.id == self.id }      
      article_num = articles.map{|a| a.permalink.last.to_i }
      
      
      max_num = article_num.sort.last
      max_num = 1 if max_num == 0
         
      if articles.nil? || articles.size == 0
        self.permalink = p
      else
        self.permalink = p + (max_num + 1).to_s
      end
    end
  end
  
  
end