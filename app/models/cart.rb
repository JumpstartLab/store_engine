class Cart < ActiveRecord::Base
  # attr_accessible :user_id
  attr_accessor :total

  belongs_to :user

  has_many :cart_products
  has_many :products, :through => :cart_products

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

  def remove_product(product)
    self.products.delete(product)
  end

  def cart_count
    cart_products.map(&:quantity).inject(:+) || 0
  end

  def cart_total
    products.inject(Money.new(0, "USD")) do |total, product|
      total + (product.price || 0)
    end
  end

end
