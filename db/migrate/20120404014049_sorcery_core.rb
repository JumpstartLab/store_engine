class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username,         :null => false  
      t.string :display_name
      t.string :first_name
      t.string :last_name
      t.references :shipping_address
      t.references :billing_address
      t.string :email,            :default => nil 
      t.string :crypted_password, :default => nil
      t.string :salt,             :default => nil
      t.boolean :admin, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
