class CartsController < ApplicationController

  def show
  end

  def destroy
    cart.destroy
    session[:cart_id] = nil
    redirect_to cart_path
  end
end
