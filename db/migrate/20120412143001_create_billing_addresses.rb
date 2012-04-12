class CreateBillingAddresses < ActiveRecord::Migration
  def change
    create_table :billing_addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :line_1
      t.string :line_2
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :phone
      t.timestamps
    end
  end
end
