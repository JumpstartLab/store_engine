class CartProductsController < ApplicationController

  def create
    cart.add_or_increment_by_product_id(params[:product_id])
    redirect_to cart_path
  end

  def destroy
    cart_product = CartProduct.find_by_id(params[:id])
    cart_product.destroy
    redirect_to cart_path
  end

  def update
    cart_product = CartProduct.find_by_id(params[:id])
    if cart_product.update_attributes(:quantity => params[:cart_product][:quantity])
      redirect_to cart_path
    else
      raise "whoops"
    end
  end

end
