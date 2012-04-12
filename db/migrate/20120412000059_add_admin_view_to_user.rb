class AddAdminViewToUser < ActiveRecord::Migration
  def change
    add_column :users, :admin_view, :boolean, default: false
  end
end
