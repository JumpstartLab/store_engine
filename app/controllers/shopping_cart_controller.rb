class ShoppingCartController < ApplicationController

  def show
    cart = ShoppingCart.find(1)
    @order_products = cart.order_products
  end

  def update
    cart = ShoppingCart.find(1)
    order_product = OrderProduct.new
    order_product.product = Product.find(params[:id])
    cart.order_products << order_product
    cart.save
    redirect_to shopping_cart_index_path
  end

end
