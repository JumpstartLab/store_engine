class UsersController < ApplicationController

  before_filter :is_current_user?, only: [ :show ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      cart = current_cart
      user = login(params[:user][:email], params[:user][:password])
      cart.assign_cart_to_user(user)
      redirect_to_last_page("Welcome! Thanks for signing up!")
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @orders = current_user.recent_orders.desc
  end

private
  def is_current_user?
    redirect_to_last_page unless User.find(params[:id]) == current_user
  end

end
