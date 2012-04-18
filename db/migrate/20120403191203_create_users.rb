class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :full_name
      t.string    :email
      t.string    :username
      t.string    :password
      t.boolean   :admin, :default => false
      t.timestamps
    end
  end
end
