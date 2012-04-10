class CreateAdvancedSearches < ActiveRecord::Migration
  def change
    create_table :advanced_searches do |t|
      t.integer :status_id
      t.integer :order_total
      t.string :order_total_operator
      t.date :order_date
      t.string :order_date_operator
      t.string :email

      t.timestamps
    end
  end
end
