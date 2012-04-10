class CartProductsController < ApplicationController

  def new
    current_cart.add_product_by_id(params[:product_id])
    redirect_to cart_path
  end

  def destroy
    CartProduct.find(params[:id]).destroy
    redirect_to cart_path
  end

  def update
    current_cart_product = CartProduct.find(params[:id])
    current_cart_product.update_quantity(params[:cart_product][:quantity])
    redirect_to cart_path
  end
end
