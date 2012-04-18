class SwitchUserIdFromStringToIntOnOrder < ActiveRecord::Migration
  
  def change
    remove_column :orders, :user_id
    add_column :orders, :user_id, :integer
  end
end
