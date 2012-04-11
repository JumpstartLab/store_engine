class CartPersistenceModifications < ActiveRecord::Migration
  def change
    remove_column :users, :cart_id, :integer
    add_column :carts, :user_id, :integer
    add_index :carts, :user_id
  end
end
