class ChangeCreditCardExpirationDateDataTypeInBillinMethods < ActiveRecord::Migration
  def change
    change_table :billing_methods do |t|
      t.change :credit_card_expiration_date, :date
    end
  end
end
