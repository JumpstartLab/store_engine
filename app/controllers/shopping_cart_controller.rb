class ShoppingCartController < ApplicationController

  def show
    cart = current_user.shopping_cart
    @cart_items = cart.cart_items
  end

  def update
    # cart = ShoppingCart.find(1)
    # order_product = OrderProduct.new
    # order_product.product = Product.find(params[:id])
    # cart.order_products << order_product
    # cart.save
    # redirect_to shopping_cart_index_path
  end

end
