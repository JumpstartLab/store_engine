class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_admin
    if current_user and current_user.admin
    else
      redirect_to root_url
    end
  end
end
