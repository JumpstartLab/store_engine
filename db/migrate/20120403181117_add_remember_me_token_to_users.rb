class AddRememberMeTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :remember_me_token, :string, :default => nil
    add_column :users, :remember_me_token_expires_at, :datetime, :default => nil
  end

  def self.down
    remove_index :users, :remember_me_token

    remove_column :users, :remember_me_token_expires_at
    remove_column :users, :remember_me_token
  end
  
end
