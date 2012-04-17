class UsersController < ApplicationController
  before_filter :lookup_user, :only => [:edit, :update, :show]


  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if session[:cart_id]
      temp_cart = Cart.find_by_id(session[:cart_id])
    end

    if @user.save
      if temp_cart
        add_session_cart_items(temp_cart)
      end
      @user = login(params[:user][:email].downcase, params[:user][:password])
      redirect_to root_url, :notice => "Logged in, New user #{@user.name}"
    else
      render :new, :notice => "Way to go."
    end
  end

  def edit

  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Updated successfully."
    else
      render :edit
    end
  end

  def show
    @orders = current_user.orders
  end

  private

  def lookup_user
    @user = current_user
  end

end