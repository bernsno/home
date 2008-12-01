class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email, :default => "", :null => false
      t.string :crypted_password, :default => nil, :null => true
      t.string :password_salt, :default => nil, :null => true
      t.string :remember_token, :null => false
      t.integer :login_count, :default => 0, :null => false
      t.datetime :last_request_at
      t.datetime :last_login_at
      t.datetime :current_login_at
      t.string :last_login_ip
      t.string :current_login_ip
      t.boolean :active, :default => false, :null => false
      t.string :perishable_token, :default => "", :null => false
      t.string :openid_identifier

      t.timestamps
    end
    
    add_index :users, :email
    add_index :users, :remember_token
    add_index :users, :perishable_token
    add_index :users, :openid_identifier
  end

  def self.down
    drop_table :users
  end
end
