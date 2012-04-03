class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = login(params[:user][:email], params[:user][:password], remember_me = false)
    if user.nil?
      @user = User.new(params[:user])
      render 'new'
    else
      redirect_to root_url
    end
  end

  def destroy
    logout
  end

end
