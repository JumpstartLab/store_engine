class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :email
      t.string :display_name
      t.integer :permission, :default => 1

      t.timestamps
    end
  end
end
