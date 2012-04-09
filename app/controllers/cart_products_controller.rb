class CartProductsController < ApplicationController

  def new
    @cart.add_product_by_id(params[:product_id])
    redirect_to cart_path
  end

  def destroy
    CartProduct.find(params[:id]).destroy
    redirect_to cart_path
  end

  def update
    quantity = params[:cart_product][:quantity]
    CartProduct.find(params[:id]).update_attribute(:quantity, quantity)
    redirect_to cart_path
  end
end
