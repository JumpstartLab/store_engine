class CreateShippingInformations < ActiveRecord::Migration
  def change
    create_table :shipping_informations do |t|
      t.integer :user_id
      t.string :shipping_address_line_1
      t.string :shipping_address_line_2
      t.string :shipping_address_city
      t.string :shipping_address_state
      t.integer :shipping_address_zipcode

      t.timestamps
    end
  end
end
