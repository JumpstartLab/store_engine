class AddBaseFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :full_name, :string
    add_column :users, :display_name, :string
    add_column :users, :billing_address, :text
    add_column :users, :shipping_address, :text
    add_column :users, :admin, :boolean
  end
end
