class SessionsController < ApplicationController
  def create
    user = lookup_by_email_or_username(params[:account_name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if session[:request_page].blank?
        redirect_to root_url
      else
        new_session = session[:request_page]
        session[:request_page] = nil
        redirect_to new_session, notice: "Logged in!"
      end
      
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
