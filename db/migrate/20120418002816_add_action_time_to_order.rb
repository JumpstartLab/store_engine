class AddActionTimeToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :action_time, :string
  end
end
