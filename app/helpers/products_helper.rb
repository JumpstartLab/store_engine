module ProductsHelper
  def current_user
    if session[:user_id]
      return User.find(session[:user_id])
    # else
    #   ### THIS IS EVIL DON"T DO THIS
    #   User.all.last
    end
  end
end
