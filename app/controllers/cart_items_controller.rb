class CartItemsController < ApplicationController

  def create
    cart_item = CartItem.new
    cart_item.quantity = params[:cart_item][:quantity]
    product = Product.find(params[:product])
    cart_item.price = product.price
    cart_item.shopping_cart = current_user.shopping_cart
    cart_item.product = product
    cart_item.save
    redirect_to shopping_cart_path
  end
end
