class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :category
      t.string :title
      t.text :description
      t.decimal :price, precision: 8, scale: 2
      t.string :status

      t.timestamps
    end
    add_index :products, :category_id
  end
end
