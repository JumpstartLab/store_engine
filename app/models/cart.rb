class Cart < Order
  attr_accessible :current_cart, :individual_quantity

  accepts_nested_attributes_for :order_products

  default_scope :conditions => { :is_cart => 1 }

  def status
    self.status = Status.find_or_create_by_name("cart")
  end

  def add_product(id)
    p = Product.find(id)
    if products.include? p
      with_order_product_id(p.id).update_quantity
    else
      products << p
    end
  end
  def merge(old_cart_id)
    old_cart = Cart.find(old_cart_id)
    old_cart.products.each do |p|
      self.add_product(p.id)
    end
  end
  def update_quantity(cps)
    cps.each do |k, v|
      select_order_product(v[:id]).update_quantity(v[:quantity])
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
