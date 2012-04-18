class SessionsController < ApplicationController

  def new
    @cart = current_cart
  end

  def create
    cart_id = current_cart.id
    user = login(params[:email], params[:password])
    if user
      session[:cart_id] = cart_id
      redirect_to cart_path(current_cart), :notice => "Logged in!"
    else
      flash.now.notice = "Email or password was invalid"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end
end
