class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email_address(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Welcome, #{user.full_name}"
    else
      render :new, :notice => 'Try again'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => 'Thanks for Visting'
  end

end
