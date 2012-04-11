class AddCartIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cart_id, :integer
  end
end
