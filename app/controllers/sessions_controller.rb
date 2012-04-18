class SessionsController < ApplicationController

  def new
    raise session.inspect
  end

  def create
    if session[:cart_id]
      temp_cart = Cart.find_by_id(session[:cart_id])
    end

    @user = login(
                  params[:email].downcase,
                  params[:password],
                  params[:remember_me]
                  )

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

end
