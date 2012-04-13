class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :find_or_create_cart
  before_filter :get_last_page
  after_filter :set_last_page

  helper_method :current_cart

  def get_last_page
    @last_page = "Your last page: #{session[:last_page]}"
  end

  def current_cart
    @cart ||= find_or_create_cart
  end

  def redirect_to_last_page(message=nil)
    last_page = session[:last_page]
    if last_page
      redirect_to(last_page, :notice => message)
    else 
      redirect_to(root_path, :notice => message)
    end
  end

  def redirect_to_login(message=nil)
    redirect_to signin_path
  end

private

  def find_or_create_cart
    if session[:cart_id] && cart = Cart.find_by_id(session[:cart_id])
      cart
    elsif current_user
      get_cart_from_user
    else
      Cart.create.tap{ |cart| session[:cart_id] = cart.id; }
    end    
  end

  def get_cart_from_user
    # raise Cart.find_by_user_id(current_user.id).inspect
    cart = current_user.cart || Cart.create!
    session[:cart_id] = cart.id
    current_user.cart = cart
  end

  def set_last_page
    session[:last_page] = request.url
  end

end
