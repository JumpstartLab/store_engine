class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string      :status
      t.decimal     :total_price, :precision => 12, :scale => 2
      t.timestamps
    end
  end
end
