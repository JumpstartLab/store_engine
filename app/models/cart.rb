# "add_to_cart", :to => "cart_item#create", :as => "add_to_cart"?

class Cart < ActiveRecord::Base
  attr_accessible :product
  has_many :cart_items, dependent: :destroy
  has_many :products, :through => :cart_items

  def items
    products
  end

  def add_or_increment_by_product(product_id)
    if product_ids.include?(product_id.to_i)
      increment_quantity_for(product_id)
    else
      add_product_by(product_id)
    end
  end

  def increment_quantity_for(product_id)
    current_item = cart_items.find_by_product_id(product_id)
    current_item.quantity += 1
    current_item.save
  end

  def add_product_by(product_id)
    product = Product.find(product_id)
    add_product(product)
  end

  def add_product(product)
    products << product
  end

  def total_price
    cart_items.inject(0) do |result, item|
      result += item.price
    end
  end

  def quantity
    cart_items.inject(0) do |result, item|
      result += item.quantity
    end
  end
end
