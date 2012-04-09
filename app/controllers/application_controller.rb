class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :find_or_create_cart

  helper_method :current_cart

  def current_cart
    @cart ||= find_or_create_cart
  end

private

  def find_or_create_cart
    if session[:cart_id]
      Cart.find_by_id(session[:cart_id])
    else
      Cart.create.tap{ |c| session[:cart_id] = c.id }      
    end    
  end
end
