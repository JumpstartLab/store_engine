class ShoppingCart < ActiveRecord::Base
  belongs_to :user
  has_many :cart_items

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

  def total
    cart_items.inject(Money.new(0)) do |sum, cart_item|
      sum += cart_item.price * cart_item.quantity
    end
  end
end
