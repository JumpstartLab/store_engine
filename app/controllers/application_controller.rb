class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_admin
    if current_user && !current_user.admin
      redirect_to root_url, :notice => "Must be an administrator"
    elsif current_user.nil?
      redirect_to '/login', :notice => "Must be an administrator"
    end
  end

  def require_not_logged_in
    redirect_to root_url, :notice => 'Must not be logged in' unless !current_user
  end
  
end
