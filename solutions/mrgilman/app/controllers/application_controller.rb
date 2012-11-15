class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user_or_admin_or_not_found
    if !current_user || current_user.id != params[:id].to_i &&
      !current_user.admin?
      not_found
    end
  end

  def admin_or_not_found
    if !current_user || !current_user.admin?
      not_found
    end
  end

  helper_method :cart
  def cart
    unless current_user
      anonymous_cart
    else
      user_cart
    end
  end

  private

  def user_cart
    unless current_user.cart?
      current_user.shopping_cart = ShoppingCart.new
    end
    current_user.shopping_cart
  end

  def anonymous_cart
    if session[:cart_id].nil?
      ShoppingCart.create.tap{ |cart| session[:cart_id] = cart.id }
    else
      ShoppingCart.find(session[:cart_id])
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
