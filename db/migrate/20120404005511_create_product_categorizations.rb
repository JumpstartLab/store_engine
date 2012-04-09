class CreateProductCategorizations < ActiveRecord::Migration
  def change
    create_table :product_categorizations do |t|
      t.integer :product_id
      t.integer :category_id

      t.timestamps
    end
  end
end
