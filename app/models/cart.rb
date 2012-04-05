class Cart < ActiveRecord::Base
  has_many :cart_items
  has_many :products, :through => :cart_items

  def items
    products
  end

  def add_item(product)
    items << product
  end

  def add_product_by_id(product_id)
    product = Product.find(product_id)
    add_item(product)
  end

end
