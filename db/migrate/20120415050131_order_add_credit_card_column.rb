class OrderAddCreditCardColumn < ActiveRecord::Migration
  def create
    add_column :orders, :credit_card_id, :integer
  end
end
