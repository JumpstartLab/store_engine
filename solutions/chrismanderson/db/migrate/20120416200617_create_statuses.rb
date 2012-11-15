class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :order_id
      t.string :name, :default => "pending"

      t.timestamps
    end
  end
end
