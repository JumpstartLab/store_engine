class OrderProduct < ActiveRecord::Base
  attr_accessible :order_id, :product_id, :quantity
  belongs_to :order
  belongs_to :product
  validates_presence_of :quantity
end
