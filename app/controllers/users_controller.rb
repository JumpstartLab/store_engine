class UsersController < ApplicationController
  def index
    @users = User.all

    respond_to do |format|
      format.html 
    end
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
        format.html { redirect_to(:users, :notice => 'Registration successful. 
                                  Check your email for activation 
                                  instructions.') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def login_from_http_basic
    redirect_to users_path, :notice => 'Login from basic auth successful'
  end
end
