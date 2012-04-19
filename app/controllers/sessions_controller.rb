class SessionsController < ApplicationController
  def new
  end

  def create
    user = check_for_cart_and_login
    session[:view_as_admin] = 'true' if user && user.admin?

    if user
      redirect_back_or_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password."
      render :new
    end
  end

  def check_for_cart_and_login
    if session[:cart_id]
      user = login_user_with_cart
    else
      user = login(params[:email], params[:password])
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
