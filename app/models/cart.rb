class Cart < Order

  def add_product_by_id(product_id)
    add_product(Product.find(product_id))
  end
end
