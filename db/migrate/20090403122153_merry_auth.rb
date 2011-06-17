class MerryAuth < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login
      t.string :email
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.integer :login_count
      t.datetime :last_request_at
      t.datetime :last_login_at
      t.datetime :current_login_at
      t.string :last_login_ip
      t.string :current_login_ip
      t.string :perishable_token, :default => "", :null => false
      t.boolean :active, :default => false, :null => false
      t.timestamps
    end
    
    create_table :roles do |t|
      t.string   "name",              :limit => 40
      t.string   "authorizable_type", :limit => 40
      t.integer  "authorizable_id"
      t.timestamps
    end
    
    create_table "roles_users", :id => false, :force => true do |t|
      t.integer  "user_id" 
      t.integer  "role_id" 
      t.datetime "created_at" 
      t.datetime "updated_at" 
    end
    
    add_index :users, :perishable_token
    add_index :users, :email
  end

  def self.down
    drop_index :users, :perishable_token
    drop_index :users, :email
    drop_table :users
    drop_table :roles, :roles_users
  end
end
