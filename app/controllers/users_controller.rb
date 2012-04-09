class UsersController < ApplicationController

  before_filter :require_user, only: [ :show ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path, :notice => "Signed up!"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
