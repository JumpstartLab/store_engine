class ApplicationController < ActionController::Base
  protect_from_forgery

  def not_authenticated
    redirect_to login_url, :alert => "SIGN IN BITCH!"
  end

  def admin?
    redirect_to root_path, :alert => "Access denied. This page is for administrators only." unless current_user.admin?
  end
end

