class LineItem < ActiveRecord::Base
  attr_accessible :order_id, :price, :product_id, :quantity
  belongs_to :product
  belongs_to :order

end
