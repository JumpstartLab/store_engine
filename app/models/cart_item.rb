class CartItem < ActiveRecord::Base
  attr_accessible :quantity
  belongs_to :cart
  belongs_to :product

  def title
    product.title
  end

  def total
    product.price * quantity
  end

  def attributes_for_order_item
    { :product_id => product_id, :quantity => quantity, :total_price => total }
  end
end