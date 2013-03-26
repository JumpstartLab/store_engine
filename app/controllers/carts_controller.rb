class CartsController < ApplicationController
  def show
    @cart = Hash[session[:cart].map { |id, quantity| [Product.find(id), quantity] }]
  end

  def update
    id = params[:product_id]
    quantity = params[:quantity]

    if quantity
      session[:cart][id] = quantity
    else
      session[:cart][id] = session[:cart][id].to_i + 1
    end

    redirect_to(:back)
  end

  def destroy
    session[:cart] = {}
    redirect_to(:back)
  end
end
