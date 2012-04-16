class UsersController < ApplicationController

  load_and_authorize_resource
  
  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_back_or_to root_url, :notice => "Signed up! Please login to continue."
    else
      render :new
    end
  end
end

