class ProductsDeleteDefaultPhoto < ActiveRecord::Migration
  def change
    change_column_default :products, :photo, nil
  end
end
