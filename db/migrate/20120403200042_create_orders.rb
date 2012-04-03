class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string      :status
      t.integer     :total_price
      t.timestamps
    end
  end
end
