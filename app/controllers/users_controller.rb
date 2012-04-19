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

  def update
    current_user.update_attributes(params[:user])
    if current_user.save
      flash[:notice] = "Updated User Info!"
      redirect_to root_path
    else
      flash[:error] = current_user.errors.full_messages.join(', ')
      redirect_to :back
    end
  end
end
