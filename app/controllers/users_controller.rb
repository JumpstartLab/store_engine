class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    result = User.register(params[:user])
    if result[:status] == 'success'
      sign_in result[:user]
      # raise result.inspect
      redirect_to cart_path
    else
      flash.now[:error] = result[:status]
      @user = User.new #How do I fix this?
      render :action => 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
