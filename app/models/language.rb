class Language < ActiveRecord::Base
  belongs_to :site_setting
  
  LOCALES = ["fr", "de", "en"]
  #LOCALES = I18n.load_path.locales
end