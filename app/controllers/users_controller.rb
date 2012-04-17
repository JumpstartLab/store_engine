class UsersController < ApplicationController
  before_filter :current_user_or_admin_or_not_found, :only => [:show]
  before_filter :admin_or_not_found, :only => [:index, :create]

  def index
    @users = User.all
  end
 
  def show
    @user = User.find(params[:id])
  end

  def new
    if logged_in? && !current_user.admin?
      redirect_to :root
    else 
      @user = User.new
    end
  end

  def edit
    id = params[:id].to_i
    if logged_in? && current_user.id == id
      @user = User.find(id)
    else
      not_found
    end
  end

  def update
    if logged_in? && current_user.id == id
      user = User.find(params[:id]).update_attributes(params[:user])
      redirect_to user_path(@user) 
    else 
      not_found
    end
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(:root, :notice => 'Registration successful.') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def login_from_http_basic
    redirect_to users_path, :notice => 'Login from basic auth successful'
  end
end
