class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :find_categories
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, notice: "ACCESS DENIED >:| CHECK YO' STEP"
  end

  def find_categories
    @categories=Category.all
  end
  private

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  helper_method :current_cart
end