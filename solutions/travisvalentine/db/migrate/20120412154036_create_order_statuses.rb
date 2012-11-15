class CreateOrderStatuses < ActiveRecord::Migration
  def change
    create_table :order_statuses do |t|
      t.integer :order_id
      t.string :status
      t.timestamps
    end
  end
end
