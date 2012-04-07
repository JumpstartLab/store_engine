class Cart < ActiveRecord::Base
  attr_accessible :current_cart

  belongs_to :user
  has_many :cart_products
  has_many :products, :through => :cart_products

  def add_product(id)
    self.products << Product.find(id)
  end

  def remove_product(id)
    self.products.delete(Product.find(id))
  end

  def add_user(current_user)
    self.user = current_user if current_user
  end

end
