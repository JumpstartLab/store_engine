class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
  has_one :order_item
  #attr_accessible :cart_id, :product_id, :product, :subtotal, :quantity, :price, :id
  attr_accessible :product_id, :product

  def subtotal
    @subtotal ||= self.product.price * quantity
  end
end
