class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_admin
<<<<<<< HEAD
    if current_user && !current_user.admin
      redirect_to root_url
    elsif current_user.nil?
      redirect_to '/login'
    end
=======
    redirect_to root_url, :notice => 'Must be administator' unless current_user && current_user.admin
>>>>>>> 9e9b569020a5f26b58133de3f46dc1c88d75fe8e
  end

  def require_not_logged_in
    redirect_to root_url, :notice => 'Must not be logged in' unless !current_user
  end
  
end
