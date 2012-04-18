# Cart object for a user / a guest
class Cart < Order
  attr_accessible :current_cart, :individual_quantity

  default_scope :conditions => { :is_cart => 1 }

  def add_product(id)
    product = Product.find(id)
    if products.include? product
      with_order_product_id(product.id).update_quantity
    else
      products << product
    end
  end

  def merge(old_cart_id)
    old_cart = Cart.find(old_cart_id)
    old_cart.products.each do |product|
      self.add_product(product.id)
    end
  end
  def update_quantity(cps)
    cps.each do |key, val|
      select_order_product(val[:id]).update_quantity(val[:quantity])
    end
  end

  def select_order_product(id)
    order_products.select { |cp| cp.id == id.to_i }.first
  end

  def remove_product(id)
    products.delete(Product.find(id))
  end

  def add_user(current_user)
    user = current_user if current_user
  end

  def with_order_product_id(id)
    order_products.where(:product_id => id).first
  end

end
