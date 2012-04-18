class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all

  private

  def cart
    @cart ||= find_or_create_cart
  end

  def find_or_create_cart
    if current_user
      session[:cart_id] = current_user.cart.id
      Cart.find_by_id(session[:cart_id])
    elsif session[:cart_id]
      Cart.find_by_id(session[:cart_id])
    else
      Cart.create.tap{ |c| session[:cart_id] = c.id }
    end
  end

 def add_session_cart_items(cart)
    if cart.cart_products.any?
      cart.cart_products.each do |cart_product|
        @user.cart.cart_products << cart_product
      end
    end
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  helper_method :current_user, :cart

  def check_logged_in
    if current_user
      true
    else
      not_authenticated
    end
  end

  helper_method :check_logged_in

  def not_authenticated
    redirect_to login_url, :alert => "First login to access this page."
  end

  def check_admin
    if current_user.is_admin?
      true
    else
      redirect_to root_url, :notice => "DON'T TOUCH THAT"
    end
  end

  helper_method :check_admin

end