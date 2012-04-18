class AddShippingDetailsTable < ActiveRecord::Migration
  def change
      create_table :shipping_details do |t|
        
      t.integer :user_id
      t.string :ship_to_name
      t.string :ship_to_address_1
      t.string :ship_to_address_2
      t.string :ship_to_city
      t.string :ship_to_state
      t.string :ship_to_country
      t.string :ship_to_zip

      t.timestamps
    end
  end
end
