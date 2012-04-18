class SessionsController < ApplicationController

  def new
    @cart = current_cart
  end

  def create
    cart_id = current_cart.id
    user = login(params[:email], params[:password])
    if user
      session[:cart_id] = cart_id
      redirect_back_or_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Email or password was invalid"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end
end
