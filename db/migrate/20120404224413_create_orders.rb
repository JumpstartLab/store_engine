class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :total_price
      t.string :status, :default => "pending"
      t.timestamps
    end
  end
end
