class OrderProduct < ActiveRecord::Base
  attr_accessible :order_id, :price_cents, :product_id, :quantity

  belongs_to :order
  belongs_to :product

  monetize :price_cents, :target_name => "price"

end
