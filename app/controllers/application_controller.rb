class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_admin
    if current_user == false
      not_authenticated
    elsif current_user.admin == true
      true
    else
      redirect_to login_path, :alert => "Only system administrators may access this page"
    end
  end

  def not_authenticated
    redirect_to login_path, :alert => "First login to access this page."
  end

end
