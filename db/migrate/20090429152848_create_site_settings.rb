class CreateSiteSettings < ActiveRecord::Migration
  def self.up
    create_table :site_settings do |t|
      t.string    :title, :default => "Default title"
      t.string    :google_analytics_key, :default => ""
    end
    
  end

  def self.down
    drop_table :site_settings
  end
end
