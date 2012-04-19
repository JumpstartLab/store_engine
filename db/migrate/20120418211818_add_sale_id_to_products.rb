class AddSaleIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :sale_id, :integer
  end
end
