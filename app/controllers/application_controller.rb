class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :cart

  private

  def cart
    @cart ||= find_or_create_cart
  end

  def find_or_create_cart
    if session[:cart_id]
      cart_finder
    else
      Cart.create.tap{ |c| session[:cart_id] = c.id }
    end
  end

  def cart_finder
    if Cart.find_by_id(session[:cart_id]).nil?
      Cart.create.tap{ |c| session[:cart_id] = c.id }
    else 
      Cart.find_by_id(session[:cart_id])
    end
  end
end
