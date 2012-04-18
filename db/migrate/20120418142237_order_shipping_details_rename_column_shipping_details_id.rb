class OrderShippingDetailsRenameColumnShippingDetailsId < ActiveRecord::Migration
  def change
    rename_column :order_shipping_details, :shipping_details_id, :shipping_detail_id
  end
end
