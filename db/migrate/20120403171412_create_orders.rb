class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :status_id
      t.string :unique_url
      
      t.datetime :shipped_at
      t.datetime :returned_at
      t.datetime :cancelled_at

      t.timestamps
    end
  end
end
