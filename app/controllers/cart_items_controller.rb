class CartItemsController < ApplicationController
  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @cart_item = @cart.cart_items.build(product: product)
    @cart_item.save
    redirect_to @cart_item.cart
  end
end
