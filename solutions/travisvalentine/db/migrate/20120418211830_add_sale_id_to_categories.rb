class AddSaleIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :sale_id, :integer
  end
end
