class ShoppingCart < ActiveRecord::Base
  belongs_to :user
  has_many :cart_items

  def merge_cart_items(other)
    other.cart_items.each do |cart_item|
      add_item(cart_item.product.id, cart_item.quantity)
    end
  end

  def add_item(product_id, quantity)
    product = Product.find(product_id)
    item = cart_items.find(:first, :conditions => ["product_id = ?", product_id])
    if item.nil?
      item = CartItem.new(:product => product, :quantity => quantity,
                          :price => product.price_string)
      cart_items << item
    else
      item.quantity += quantity.to_i
      item.save
    end
  end

  def remove_item(cart_item_id)    
    cart_item = cart_items.find(cart_item_id).destroy
  end

  def update_quantities(item_to_quantities)
    cart_items.each do |cart_item|
      cart_item.quantity = item_to_quantities[cart_item.id.to_s]
      cart_item.save
    end
  end

  def total
    cart_items.inject(Money.new(0)) do |sum, cart_item|
      sum += cart_item.price * cart_item.quantity
    end
  end

  def clear
    cart_items.clear
  end

  def item_count
    count = 0
    cart_items.each do |cart_item|
      count +=  cart_item.quantity
    end
    if count == 1
      "1 item"
    else
      "#{count} items"
    end
  end
end
