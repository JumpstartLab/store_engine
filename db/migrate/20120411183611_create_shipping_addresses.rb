class CreateShippingAddresses < ActiveRecord::Migration
  def change
    create_table :shipping_addresses do |t|
      t.string :street
      t.string :state
      t.string :zipcode
      t.string :city
      t.string :name
      t.string :email_address

      t.timestamps
    end
  end
end
