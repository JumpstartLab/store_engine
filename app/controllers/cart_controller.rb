class CartController < ApplicationController
  
  def index
     @products = current_cart.collect do |p|     
        [ p[0], Product.find(p[1]) ]
     end     
  end

  def update
    current_cart << [1,params[:id]]
    save_json_cart
    redirect_to '/cart', :notice => "Item added."
  end

  def current_cart
    load_json_cart
    @current_cart ||= []
    save_json_cart
    @current_cart
  end

  def save_json_cart
    cookies[:cart] = @current_cart.to_json
  end

  def load_json_cart
    @current_cart = JSON.load(cookies[:cart])
  end

end
