module ProductsHelper

  def add_class_disabled?(product)
    if product.retired
      "disabled"
    end
  end

end