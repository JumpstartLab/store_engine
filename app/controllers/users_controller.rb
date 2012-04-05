class UsersController < ApplicationController
  before_filter :lookup_user, :only => [:show, :edit, :destroy, :update]
  before_filter :require_user

    def require_user
      if session[:user_id] == nil
        redirect_to root_url, :notice => "No way! You Need Admin Access"
      end
    end

    def index
      @users = User.all
    end

    def show
    end

    def new
      @user = User.new
    end

    def create
      user = User.new(params[:user])
      user.save
      redirect_to user_path(user)
    end

    def destroy
      User.destroy(@user)
      redirect_to users_path
    end

    def edit
    end

    def update
      @user.update_attributes(params[:user])
      redirect_to user_path(@user)
    end

    private

    def lookup_user
      @user = User.find(params[:id])
    end
end
