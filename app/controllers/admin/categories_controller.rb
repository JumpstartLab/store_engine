class Admin::CategoriesController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user
  
  def index
    @categories = Category.all
  end

  def show
  end

  def edit
  end

  def update
    category.update_attributes(params[:category])
    redirect_to admin_categories_path
  end

  def new
    @category = Category.new
  end

  def create
    category = Category.new(params[:category])
    category.save
    redirect_to admin_categories_path
  end

  def destroy
    category.destroy
    redirect_to admin_categories_path
  end

  helper_method :category

  private

    def category
      @category ||= Category.find(params[:id])
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end

    def admin_user
      redirect_to(root_path) && flash_error unless current_user.admin?
    end

    def flash_error
      flash[:error] = "You are not logged in as the correct user"
    end  
end
