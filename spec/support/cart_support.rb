module CartSupport
  def load_cart_with_products(products)
    products.each do |p|
      visit product_path(p)
      click_link_or_button("Add to Cart")
    end
  end
end