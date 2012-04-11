class Retirement

  def initialize(product_id)
    @product = Product.find(product_id)
  end

  def retire
    @product.retire
  end

end