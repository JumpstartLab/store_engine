class UsersController < ApplicationController
  before_filter :lookup_user, :only => [:show, :edit, :destroy, :update]
  before_filter :require_user, :except => [:new, :create]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html { redirect_to user_path(@user), notice: 'Product was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
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

  def require_user
    if session[:user_id] == nil
      redirect_to root_url, :notice => "No way! You Need Admin Access"
    end
  end

end
