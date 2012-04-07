class Cart < ActiveRecord::Base
  attr_accessible :product
  has_many :cart_items, dependent: :destroy
  has_many :products, :through => :cart_items

  def items
    products
  end
end
