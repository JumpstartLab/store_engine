class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  # attr_accessor :product_quantity
end
