class TranslationForMerryCms < ActiveRecord::Migration
  def self.up
    Article.create_translation_table! :title => :string, :intro => :text, :content => :text, :permalink => :string
    Category.create_translation_table! :name => :string, :permalink => :string
  end

  def self.down
    Article.drop_translation_table!
    Category.drop_translation_table!
  end
end
