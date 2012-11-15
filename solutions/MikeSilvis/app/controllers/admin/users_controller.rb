# Allows creating and modifying users
class Admin::UsersController < AdminController

  def index
    @users = User.all
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path
  end
  
end
