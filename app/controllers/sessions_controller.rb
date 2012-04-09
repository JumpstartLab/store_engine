class SessionsController < ApplicationController

  def create
    if session[:cart_id]
      @products = Cart.find_by_id(session[:cart_id]).products
    end

    @user = login(params[:email], params[:password], params[:remember_me])

    if @user
      # if session[:cart_id]
      #   add_session_cart_items
      # end
      if @products
        @products.each do |product|
          @user.cart.products << product
        end
      end
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

  def add_session_cart_items
    session_products = Cart.find_by_id(session[:cart_id]).products
    session_products.each do |product|
      @user.cart.products << product
    end
  end
end
