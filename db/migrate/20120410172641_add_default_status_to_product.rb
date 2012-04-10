class AddDefaultStatusToProduct < ActiveRecord::Migration
  def change
    change_column_default :products, :status, 'active'
  end
end
