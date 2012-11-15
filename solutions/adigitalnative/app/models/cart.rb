class Cart < ActiveRecord::Base
  has_many :cart_items
  has_many :products, :through => :cart_items
  belongs_to :user

  def add_or_increment_by_product_id(product_id)
    if product_ids.include?(product_id.to_i)
      increment_quantity_for(product_id)
    else
      add_product_by_id(product_id)
    end
  end

  def increment_quantity_for(product_id)
    cart_item = cart_items.find_by_product_id(product_id)
    cart_item.quantity += 1
    cart_item.save
    return cart_item.quantity
  end

  def add_product(product)
    products << product
  end

  def add_product_by_id(product_id)
    product = Product.find(product_id)
    add_product(product)
  end

  def total
    cart_items.sum{|item| item.total }
  end

end
