class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :find_or_create_cart

  helper_method :current_cart

  def current_cart
    @cart ||= find_or_create_cart
  end

private

  def find_or_create_cart
    if session[:cart_id] && cart = Cart.find_by_id(session[:cart_id])
      cart
    elsif current_user && current_user.cart
      #sets session id once and will get caught by first if on next pass.
      session[:cart_id] = current_user.cart.id
      current_user.cart
    else
      Cart.create.tap{ |cart| session[:cart_id] = cart.id }      
    end    
  end
end
