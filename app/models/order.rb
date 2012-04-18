class Order < ActiveRecord::Base
  attr_accessible :status

  has_many :order_items, :dependent => :destroy
  has_many :products, :through => :order_items
  belongs_to :user

  def status_options
    ["pending", "cancelled", "paid", "shipped", "returned"]
  end

  def self.create_order_from_cart(cart, current_user)
    new_order = new
    cart.cart_items.each do |cart_item|
      new_order.order_items.build(cart_item.attributes_for_order_item, 
                                  :without_protection => true)
    end    
    new_order.total_price = cart.total
    new_order.user = current_user
    new_order.save
    return new_order
  end

  def total
    @total ||= order_items.inject(0) do |sum, order_item|
      sum += order_item.total_price
    end
  end

  # def add_product(product)
  #   products << product
  # end

  # def add_product_by_id(product_id)
  #   product = Product.find(product_id)
  #   add_product(product)
  # end
end
