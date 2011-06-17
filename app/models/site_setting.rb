class SiteSetting < ActiveRecord::Base
  validates_presence_of :title, :message => I18n.t('site.errors.title_cant_be_blank')
  
  has_many :languages
  
  def self.language_codes
    self.find(:first).languages.map{|l| l.code }
  end
  
  def language_codes
    self.languages.map{|l| l.code }
  end
  
end