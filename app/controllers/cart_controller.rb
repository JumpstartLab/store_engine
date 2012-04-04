class CartController < ApplicationController
  
  def create
    current_cart << { p[:product][:id] => 1 }
  end

  def current_cart
    cookies[:cart] ||= []
  end

end
