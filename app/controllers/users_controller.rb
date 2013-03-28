class UsersController < ApplicationController
  #before_filter :require_login, only: [:checkout] #I don't think we have a checkout page yet to require this for
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to root_url, :notice => "Welcome, #{@user.full_name}"
    else
      render :action => 'new'
    end
  end

  def show
    @user = User.find(current_user.id)
    @orders = @user.orders
  end
end
