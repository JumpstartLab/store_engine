class ApplicationController < ActionController::Base
  protect_from_forgery

  def not_authenticated
    redirect_to login_url, :alert => "SIGN IN BITCH!"
  end

  def admin?
    alert = "Access denied. This page is for administrators only."
    redirect_to root_path, :alert => alert unless current_user.admin?
  end
end

