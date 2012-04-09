class AddUserIdToBillingMethod < ActiveRecord::Migration
  def change
    add_column :billing_methods, :user_id, :integer
  end
end
