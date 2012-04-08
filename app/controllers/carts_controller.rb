class CartsController < ApplicationController
  before_filter :skip_mini_cart, only: :show
  def destroy
    current_cart.destroy
    flash[:notice] = "Cart cleared!"
    redirect_to request.referer
  end

  def show

  end
end
