class Cart < ActiveRecord::Base
  attr_accessor :total, :user_id

  has_many :cart_products, :dependent => :destroy
  has_many :products, :through => :cart_products
  belongs_to :user
  validates_uniqueness_of :user_id

  def add_product_by_id(id)
    product = Product.find(id)
    add_product(product)
  end

  def remove_product_by_id(id)
    product = Product.find(id)
    remove_product(product)
  end

  def product_if_product_id_exists(id)
    self.cart_products.find_by_product_id(id)
  end

  def add_product(product)
    if existing_product = product_if_product_id_exists(product.id)
      existing_product.update_attribute( :quantity, existing_product.quantity + 1 )
    else
      self.cart_products.create( :cart_id => self.id, :product_id => product.id, 
                                 :quantity => 1 )
    end
  end

  def assign_cart_to_user(user)
    if has_products?
      user.cart.destroy if user.cart #if user has cart, destroy
      user.cart = self
    else
      destroy #if cart has no products, destroy
    end
  end

  def remove_product(product)
    self.products.delete(product)
  end

  def cart_count
    cart_products.map(&:quantity).inject(:+) || 0
  end

  def has_products?
    cart_products.any?
  end

  def cart_total
    products.inject(Money.new(0, "USD")) do |total, product|
      total + (product.price || 0)
    end
  end

end
