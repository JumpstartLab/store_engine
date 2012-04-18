#
class UsersController < ApplicationController
  before_filter :lookup_user,
                :only => [:show, :edit, :destroy, :update, :view_as_admin,
                          :view_as_normal]
  before_filter :require_user, :only => [:edit, :update]
  before_filter :require_user_or_admin, :only => [:show]
  before_filter :require_admin, :only => [:index, :destroy]

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
    @notice = 'Welcome Aboard'
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to root_url, notice: @notice }
      else
        format.html { render action: "new" }
      end
    end
  end

  def edit
  end

  def update
    @user.update_attributes(params[:user])
    redirect_to user_path(@user)
  end

  def view_as_admin
    session[:return_to] = request.referrer
    @user.enable_admin_view
    redirect_to session[:return_to], notice: "Viewing as admin"
  end

  def view_as_normal
    session[:return_to] = request.referrer
    @user.disable_admin_view
    redirect_to session[:return_to], notice: "Viewing as normal user"
  end

  private

  def lookup_user
    @user = User.find(params[:id])
  end

end
