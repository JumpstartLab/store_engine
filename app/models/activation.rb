class Activation

  def initialize(product_id)
    @product = Product.find(product_id)
  end

  def activate
    @product.activate
  end

end