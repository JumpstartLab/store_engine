class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string  :street
      t.string  :zipcode
      t.integer :user_id
      t.string  :state
      t.string  :country
      t.string  :formatted_address
      t.timestamps
    end
  end
end
