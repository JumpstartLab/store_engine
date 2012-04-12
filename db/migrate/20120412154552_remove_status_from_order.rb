class RemoveStatusFromOrder < ActiveRecord::Migration
  def up
    remove_column :orders, :status, :string
  end

  def down
  end
end
