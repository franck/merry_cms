class MerryCms < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string    :title
      t.string    :permalink
      t.text      :intro
      t.text      :content
      t.string    :state
      t.datetime  :published_at
      t.datetime  :archived_at
      t.integer   :category_id
      
      t.timestamps
    end
    
    create_table :tags do |t|
      t.column :name, :string
    end
    
    create_table :taggings do |t|
      t.column :tag_id, :integer
      t.column :taggable_id, :integer
      t.column :tagger_id, :integer
      t.column :tagger_type, :string
      
      # You should make sure that the column created is
      # long enough to store the required class names.
      t.column :taggable_type, :string
      t.column :context, :string
      
      t.column :created_at, :datetime
    end
    
    create_table :categories do |t|
      t.string  :name
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.string  :permalink
      
      t.timestamps
    end
    
    create_table :assets do |t|
      t.string    :name
      t.string    :image_file_name
      t.string    :image_content_type
      t.integer   :image_file_size
      t.datetime  :image_updated_at
      t.timestamps
    end
        
    add_index :articles, :permalink
    add_index :taggings, :tag_id
    add_index :taggings, [:taggable_id, :taggable_type, :context]
  end

  def self.down
    remove_index :articles, :permalink
    drop_table :articles
    drop_table :taggings
    drop_table :tags
    drop_table :categories
    drop_table :assets
  end
  
end
