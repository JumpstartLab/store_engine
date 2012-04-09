class CreateBillingMethods < ActiveRecord::Migration
  def change
    create_table :billing_methods do |t|
      t.integer :credit_card_number
      t.integer :credit_card_expiration_date
      t.string :street
      t.string :city
      t.string :state
      t.integer :zipcode
      t.string :name

      t.timestamps
    end
  end
end
