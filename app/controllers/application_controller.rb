class ApplicationController < ActionController::Base
  protect_from_forgery

protected

  def ensure_admin
    # do something
  end

  def ensure_user
    # do something
  end

  def find_or_create_cart
    session[:cart] ||= Hash.new(0)
  end
end
