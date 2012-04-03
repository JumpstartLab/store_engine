class CreateCategoryProducts < ActiveRecord::Migration
  def change
    create_table :category_products, :id => false do |t|
      t.references :category, :null => false
      t.references :product, :null => false

      t.timestamps
    end
  end
end
