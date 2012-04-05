class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.boolean :is_admin, :default => false
      t.string :full_name
      t.string :email
      t.string :username

      t.timestamps
    end
  end
end
