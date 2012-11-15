class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :status
      t.references :user
      t.references :shipping_address
      t.references :billing_address
      t.datetime :status_updated_at
      t.timestamps
    end
  end
end
