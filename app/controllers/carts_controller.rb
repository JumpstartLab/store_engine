class CartsController < ApplicationController

  def destroy
    current_cart.destroy
    flash[:notice] = "Cart cleared!"
    redirect_to request.referer
  end
end
