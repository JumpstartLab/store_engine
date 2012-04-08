class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in result[:user]
      redirect_to cart_path
    else
      # raise @user.errors.messages[:email].inspect
      flash.now[:error] = 'Please correct the errors below.'
      render :action => 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
