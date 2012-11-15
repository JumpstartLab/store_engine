class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :status_id
      t.string :unique_url
      t.integer :is_cart, :default => 1


      t.datetime :shipped_at
      t.datetime :returned_at
      t.datetime :cancelled_at

      t.timestamps
    end
  end
end
