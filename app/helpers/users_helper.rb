module UsersHelper

  def logged_in?
    session[:user_id]
  end

  def current_user
    return User.find(session[:user_id]) if logged_in?
  end

  def admin?
    if current_user.present?
      current_user.admin
    else
      false
    end
  end

  def admin_view?
   if current_user.present?
      current_user.admin_view
    else
      false
    end
  end

end
