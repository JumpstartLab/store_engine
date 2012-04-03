class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.integer :price_in_cents
      t.integer :category_id

      t.timestamps
    end
  end
end
