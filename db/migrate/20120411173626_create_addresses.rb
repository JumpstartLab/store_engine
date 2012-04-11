class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :street_two
      t.string :city
      t.string :state
      t.string :country
      t.string :zipcode
      t.string :phone_number
      t.timestamps
    end
  end
end
