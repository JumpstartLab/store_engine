class Cart < ActiveRecord::Base
  # attr_accessible :user_id

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

  def add_product(product)
    self.products ||= [ ]
    self.products << product
  end

  def remove_product(product)
    self.products.delete(product)
  end

end
