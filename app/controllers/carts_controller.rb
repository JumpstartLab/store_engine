class CartsController < ApplicationController
  
  def update
    @cart.add_product(params[:product_id])
    redirect_to cart_path, :notice => "Product added to cart"
  end

  def show
  end

  def destroy
    @cart.remove_product(params[:product_id])
    redirect_to cart_path, :notice => "Product deleted."
  end

  def checkout

  end
  
end
