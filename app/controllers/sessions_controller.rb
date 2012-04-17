class SessionsController < ApplicationController

  def new
  end

  def create
    cart = current_cart
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      cart.assign_cart_to_user(user)
      redirect_back_or_to user, :notice => "Logged in!"
    else
      flash.now.alert = "Email or password was invalid."
      session[:cart_id] = cart.id
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out."
  end

end
