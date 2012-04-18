class Admin::DashboardController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user

  def index
  end

  private 

    def admin_user
      redirect_to(root_path) && flash_error unless current_user.admin?
    end

    def flash_error
      flash[:error] = "You are not logged in as the correct user"
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end
end
