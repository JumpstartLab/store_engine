class ApplicationController < ActionController::Base
  include UsersHelper

  protected

  def require_user
    if session[:user_id] == nil
      redirect_to root_url, :notice => "Please Sign In First"
    end
  end

  def require_admin
    unless admin?
      redirect_to root_url, :notice => "Unauthorized Access"
      false
    end
  end

end
