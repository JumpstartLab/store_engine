class SessionsController < ApplicationController

  def create
    if session[:cart_id]
      temp_cart = Cart.find_by_id(session[:cart_id])
    end

    @user = login(params[:email], params[:password], params[:remember_me])

    if @user
      add_session_cart_items(temp_cart) if temp_cart
      redirect_back_or_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid login/password."
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end

  private

  def add_session_cart_items(cart)
    if cart.products.any?
      cart.products.each do |product|
        @user.cart.products << product
      end
    end
  end
end
