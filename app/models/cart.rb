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

  # def cart_item(product_id)
  #   # product = Product.find(product_id)
  #   cart_item = CartItem.find(product_id)
  # end

  def test
    specified_products = {}
    products.each do |product|
      specified_products[product.id] += 1
    end
    specified_products
  end

  def product_quantity(product_id)
  end

end
