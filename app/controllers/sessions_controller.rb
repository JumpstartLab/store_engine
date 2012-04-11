class SessionsController < ApplicationController

  def new

  end

  def create
    cart_id = current_cart.id
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      user.update_attribute(:cart_id, cart_id)
      redirect_back_or_to user, :notice => "Logged in!"
    else
      flash.now.alert = "Email or password was invalid."
      # session[:cart_id]
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out."
  end

end
