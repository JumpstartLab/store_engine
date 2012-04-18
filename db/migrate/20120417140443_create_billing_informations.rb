class CreateBillingInformations < ActiveRecord::Migration
  def change
    create_table :billing_informations do |t|
      t.integer   :user_id
      t.string    :credit_card_type
      t.integer   :credit_card_number
      t.date      :credit_card_expiration
      t.string    :billing_address_line_1
      t.string    :billing_address_line_2
      t.string    :billing_address_city
      t.string    :billing_address_state
      t.integer   :billing_address_zipcode

      t.timestamps
    end
  end
end
