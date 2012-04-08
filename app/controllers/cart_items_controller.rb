class CartItemsController < ApplicationController
  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @cart_item = @cart.add_product(product.id)
    @cart_item.save
    redirect_to @cart_item.cart
  end
end
