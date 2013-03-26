module CartHelper
  def total
  end

  def subtotal
    product.price * quantity
  end
end
