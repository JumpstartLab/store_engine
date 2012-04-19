class ApplicationController < ActionController::Base
  protect_from_forgery
  after_filter :return_last_page
  helper_method :cart

  include SessionsHelper

  def redirect_to_last_page
    last_page = session[:last_page] || params[:last_page]
    if last_page
      redirect_to(last_page)
    else
      redirect_to(root_path)
    end
  end

  private

    def cart
      @cart ||= find_or_create_cart
    end

    def find_or_create_cart
      if session[:cart_id]
        cart_finder
      else
        Cart.create.tap{ |cart| session[:cart_id] = cart.id }
      end
    end

    def cart_finder
      if Cart.find_by_id(session[:cart_id]).nil?
        Cart.create.tap{ |cart| session[:cart_id] = cart.id }
      else
        Cart.find_by_id(session[:cart_id])
      end
    end

    def return_last_page
      session[:last_page] = request.url
    end
end
