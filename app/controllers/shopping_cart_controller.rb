class ShoppingCartController < ApplicationController

  def show
    @cart_items = cart.cart_items
  end

  def update
    cart.cart_items.each do |cart_item|
      cart_item.quantity = params[:quantity][cart_item.id.to_s]
      cart_item.save
    end
    redirect_to shopping_cart_path
  end
end
