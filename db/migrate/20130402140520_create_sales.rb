class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :foreign_key
      t.integer :percent_off, default: 1
      t.string :group
      t.string :status

      t.timestamps
    end
  end
end
