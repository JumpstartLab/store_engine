class Admin::ProductsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user

  def index
    @products = Product.paginate(page: params[:page])
  end

  def show
  end

  def edit
  end

  def update
    product.update_attributes(params[:product])
    redirect_to admin_product_path(product)
  end

  def destroy
    product.destroy
    redirect_to admin_products_path
  end

  def new
    @product = Product.new
  end

  def create
    product = Product.create(params[:product])
    # product.save
    redirect_to admin_product_path(product)
  end

  helper_method :product

  private

    def product
      @product ||= Product.find(params[:id])
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
