class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all


  def not_authenticated
    redirect_to login_url, :alert => "First login to access this page."
  end

  private

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  helper_method :current_user

end