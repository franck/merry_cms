class CreateLanguages < ActiveRecord::Migration
  def self.up
    create_table :languages do |t|
      t.string  :code
      t.integer :site_setting_id
    end
  end

  def self.down
    drop_table :site_languages
  end
end
