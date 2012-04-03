class OrderProduct < ActiveRecord::Base
  belongs_to :shopping_cart
  belongs_to :order
  belongs_to :product
  attr_accessible :quantity, :price

  def title
    product.title
  end
end
