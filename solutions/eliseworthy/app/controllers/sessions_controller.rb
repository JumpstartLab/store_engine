class SessionsController < ApplicationController

  def new
    @cart = current_cart
  end

  def create
    set_cart_and_user
    if @user
      session[:cart_id] = @cart_id
      redirect_to cart_path(current_cart), :notice => "Logged in!"
    else
      flash.now.notice = "Email or password was invalid"
      render :new
    end
  end

  def set_cart_and_user
    @cart_id = current_cart.id
    @user = login(params[:email], params[:password])
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end
end
