class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :zipcode
      t.integer :user_id

      t.timestamps
    end
  end
end
