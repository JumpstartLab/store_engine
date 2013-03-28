class UsersController < ApplicationController
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
