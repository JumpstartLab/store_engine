class UsersController < ApplicationController
  before_filter :admin?, :only => [:index, :new, :create]

  def index
    @users = User.all
  end
 
  def new
    @user = User.new

    respond_to do |format|
      format.html 
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
