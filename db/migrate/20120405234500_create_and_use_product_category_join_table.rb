class CreateAndUseProductCategoryJoinTable < ActiveRecord::Migration
  def change
    create_table :product_categories do |t|
      t.references :product
      t.references :category
    end

    remove_column :products, :category_id
  end
end
