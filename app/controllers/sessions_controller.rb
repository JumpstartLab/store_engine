class SessionsController < ApplicationController
  def create
    user = lookup_by_email_or_username(params[:account_name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to session[:request_page], notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:cart_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

  private

  def lookup_by_email_or_username(account_name)
    u = User.find_by_email(account_name)
    if u.nil?
      u = User.find_by_username(account_name)
    end
    u
  end
end
