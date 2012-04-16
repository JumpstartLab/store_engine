class AddRetiredToProduct < ActiveRecord::Migration
  def change
    add_column :products, :retired, :string, default: false
  end
end
