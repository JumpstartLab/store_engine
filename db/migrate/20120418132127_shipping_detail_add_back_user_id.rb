class ShippingDetailAddBackUserId < ActiveRecord::Migration
  def change
    add_column :shipping_details, :user_id, :integer
  end
end
