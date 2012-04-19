class SessionsController < ApplicationController

  def new
  end

  def create
    check_for_temp_cart
    login_user_from_params

    if @user
      add_cart_items_and_redirect
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
  def login_user_from_params
    @user = login(
                  params[:email].downcase,
                  params[:password],
                  params[:remember_me]
                  )
  end

  def check_for_temp_cart
    if session[:cart_id]
      @temp_cart = Cart.find_by_id(session[:cart_id])
    end
  end

  def add_cart_items_and_redirect
    add_session_cart_items(@temp_cart) if @temp_cart
    redirect_back_or_to root_url, :notice => "Logged in!"
  end

end
