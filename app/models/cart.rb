class Cart < ActiveRecord::Base
  attr_accessible :product
  has_many :cart_items, dependent: :destroy
  has_many :products, :through => :cart_items

  def items
    products
  end

  def add_product(product_id)
    current_item = cart_items.find_by_product_id(product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = cart_items.build(product_id: product_id)
    end
    current_item
  end
end
