class ProductsUpdateRetireDefault < ActiveRecord::Migration
  def change
    change_column_default :products, :retired, false
  end
end
