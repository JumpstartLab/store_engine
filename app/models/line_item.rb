class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
  has_one :order_item
  attr_accessible :cart_id, :product_id, :product, :subtotal, :quantity, :price, :id

  def price
    @price ||= self.product.price
  end

  def subtotal
    @subtotal ||= price * quantity
  end
end
