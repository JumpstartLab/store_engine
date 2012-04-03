class UsersController < ApplicationController

  before_filter :require_login, only: :edit

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    user = User.create!(params[:user])
    auto_login(user)
    redirect_to login_path
    flash.now.alert = "User created!"
  end

end
