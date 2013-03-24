class ProductsController < ApplicationController
  # def index
  #   #This returns all products that are not retired.
  #   @products = Product.find_all_by_status('active')
  # end
  def index
    @products = Product.get_products(params[:cateogory_id])
    @categories = Category.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to admin_products_path, :notice => "Successfully created product."
    else
      render :action => 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      redirect_to admin_products_path, :notice  => "Successfully updated product."
    else
      render :action => 'edit'
    end
  end

  # def destroy
  #   @company = Company.find(params[:id])
  #   @company.destroy
  #   redirect_to companies_url, :notice => "Successfully destroyed company."
  # end
end
