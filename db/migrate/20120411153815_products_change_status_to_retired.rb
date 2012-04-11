class ProductsChangeStatusToRetired < ActiveRecord::Migration
  def change
    remove_column :products, :status, :string
    add_column :products, :retired, :boolean
  end
end
