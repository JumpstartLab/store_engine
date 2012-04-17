class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :percent_off
      t.timestamp :end_at

      t.timestamps
    end
  end
end
