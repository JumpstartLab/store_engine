class Cart < ActiveRecord::Base
  attr_accessible :user_id
  belongs_to :user

  has_many :cart_products
  has_many :products, :through => :cart_products

  def add_product_by_id(product_id)
    product = Product.find_by_id(product_id)
    cp = create_cart_product_for_new_product(product)
    cp.save
  end

  # Made this funky to satisfy reek
  def create_cart_product_for_new_product(product)
    cp = cart_products.create
    cp.product = product
    cp.quantity = 1
    cp.price = product.best_price
    cp
  end

  def remove_product_by_id(product_id)
    product = Product.find_by_id(product_id)
    products.delete(product)
  end

  def total
    cart_products.sum(&:total)
  end

  def add_or_increment_by_product_id(product_id)
    if product_ids.include?(product_id.to_i)
      increment_quantity_for(product_id)
    else
      add_product_by_id(product_id)
    end
  end

  def increment_quantity_for(product_id)
    cart_product = cart_products.find_by_product_id(product_id)
    cart_product.quantity += 1
    cart_product.save
    return cart_product.quantity
  end

  def empty
    products.replace([])
    save
  end

  def merge(temp_cart)
    temp_cart.cart_products.each do |cart_product|
      product = cart_product.product
      if product_ids.include?(product.id)
        increment_quantity_for(product.id)
      else
        cart_products << cart_product
      end
    end
  end

  def total_items
    cart_products.sum(&:quantity)
  end
end
