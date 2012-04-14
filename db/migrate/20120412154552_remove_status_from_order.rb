class RemoveStatusFromOrder < ActiveRecord::Migration
  def up
    remove_column :orders, :status
  end

  def down
  end
end
