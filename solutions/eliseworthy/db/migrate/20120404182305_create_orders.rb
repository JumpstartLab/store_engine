class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :name
      t.string :address
      t.string :email
      t.string :status, default: "pending"
      t.datetime :shipped_at
      t.datetime :cancelled_at
      t.string :shipping_address
      t.string :cc_number
      t.string :cc_expiry
      t.timestamps
    end
  end
end
