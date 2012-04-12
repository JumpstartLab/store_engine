class Order < ActiveRecord::Base
  attr_accessible :billing_address, :shipping_address, 
                  :transactionsuser_id, :billing_address_id, 
                  :shipping_address_id, :status, :user_id
                  
  belongs_to :user

  has_many :order_products
  has_many :products, :through => :order_products

  has_many :transactions

  belongs_to :billing_address, :class_name => "Address"
  belongs_to :shipping_address, :class_name => "Address"

  # accepts_nested_attributes_for :billing_address, :shipping_address, :transactions

  def add_products_by_cart_id(cart_id)
    cart = Cart.find_by_id(cart_id.to_i)
    cart.cart_products.each do |cp|
      create_order_product_from_cart_product(cp)
    end
    cart.empty
  end

  def create_order_product_from_cart_product(cart_product)
    order_product = order_products.new
    order_product.product_id = cart_product.product_id
    order_product.quantity = cart_product.quantity
  end

end
