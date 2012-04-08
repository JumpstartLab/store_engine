class CartItemsController < ApplicationController
  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @cart_item = @cart.add_product(product.id)
    @cart_item.save
    redirect_to @cart_item.cart
  end

  def edit
    @cart = CartItem.find(params[:id])
  end

  def update
    @cart = CartItem.find(params[:id])
    @cart.update_attributes(params[:cart_item])
    redirect_to carts_path(@cart)
  end

end
