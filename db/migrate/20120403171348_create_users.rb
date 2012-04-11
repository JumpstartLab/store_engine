class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :crypted_password
      t.string :salt,                 :default => nil
      t.string :email
      t.string :display_name
      t.integer :permission,          :default => 1
      t.integer :active,              :default => 1
      t.string :stripe_id

      t.timestamps
    end
  end
end
