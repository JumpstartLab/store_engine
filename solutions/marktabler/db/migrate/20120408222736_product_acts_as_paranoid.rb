class ProductActsAsParanoid < ActiveRecord::Migration
  def change
    add_column :products, :deleted_at, :datetime
  end
end
