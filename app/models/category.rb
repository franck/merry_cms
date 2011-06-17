#require 'transform.rb'

class Category < ActiveRecord::Base

  before_validation :set_permalink
  translates :name, :permalink

  acts_as_nested_set
  
  has_many :articles
  
  validates_presence_of :name, :message => I18n.t('categories.error_messages.name_cant_be_blank')
  
  #has_permalink :name, :update => true
    
  def remove_root
    self.self_and_ancestors.delete_if{|a| a.root? }
  end
  
  def path
    path = self.remove_root.map{|c| c.name }.join(" / ")
    path.blank? ? I18n.t("categories.none") : path
  end
  
  def translated_languages
    self.globalize_translations.map{|translation|translation.locale.to_s unless translation.name.nil? }.compact!
  end
    
  def not_translated_languages
    translated = self.translated_languages
    not_translated = SiteSetting.language_codes - translated
    return not_translated
  end
  
  protected
  
  def set_permalink
    if self.permalink.blank? || self.name_changed?
      p = self.name.to_url
      
      categories = CategoryTranslation.find :all do
        permalink =~ "%#{p}%"
      end
      
      if categories.nil? || categories.size == 0
        self.permalink = p
      else
        self.permalink = p + (categories.size + 1).to_s
      end
    end
  end
  
end
