class UsersController < ApplicationController
  before_filter :lookup_user, :only => [:edit, :update, :show]


  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Welcome!"
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
