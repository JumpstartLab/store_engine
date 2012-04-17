class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :price_in_cents
      t.integer :active, :default => 1
      t.timestamp :inactive_date
      t.integer :sale_id
      
      t.timestamps
    end
  end
end
