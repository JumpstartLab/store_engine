class SessionsController < ApplicationController
  def new
  end

  def create
    if session[:cart_id]
      user = login_user_with_cart 
    else
      user = login(params[:email], params[:password])
    end

    if user
      redirect_back_or_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Email or password was invalid, fucker."
      render :new
    end
  end

  def login_user_with_cart
    cart_id = session[:cart_id]

    user = login(params[:email], params[:password])
    
    session[:cart_id] = cart_id
    user
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out."
  end
end
