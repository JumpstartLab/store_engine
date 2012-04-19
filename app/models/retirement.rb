class Retirement

  attr_accessor :product

  def initialize(product_id)
    self.product = Product.find(product_id)
  end

  def retire
    self.product.retire
  end

  def activate
    self.product.activate
  end
end