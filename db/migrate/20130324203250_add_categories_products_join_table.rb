class AddCategoriesProductsJoinTable < ActiveRecord::Migration
  def change
    create_table :categories_products do |t|
      t.references :category
      t.references :product
    end
  end
end
