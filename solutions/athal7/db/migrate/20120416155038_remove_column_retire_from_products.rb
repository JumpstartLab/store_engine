class RemoveColumnRetireFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :retired
  end
end
