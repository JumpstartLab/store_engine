class CreateStatusesTable < ActiveRecord::Migration
  def change
    remove_column :orders, :status, :string

    create_table :order_statuses do |t|

      t.string :status
      t.string :order_id
      t.timestamps
    end
  end
end
