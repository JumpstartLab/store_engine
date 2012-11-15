class OrderShippingDetail < ActiveRecord::Base
  attr_accessible :order_id, :shipping_detail_id

  belongs_to :order
  belongs_to :shipping_detail
end
