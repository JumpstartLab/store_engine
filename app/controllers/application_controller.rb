class ApplicationController < ActionController::Base
  protect_from_forgery

  def cart
    if current_user.nil?
      #ShoppingCart.new
    else
      current_cart = current_user.shopping_cart
      if current_cart.nil?
        current_cart = ShoppingCart.new
        current_user.shopping_cart = current_cart
        current_user.save 
      end  
    end
    current_cart
  end
end
