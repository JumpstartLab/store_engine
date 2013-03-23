class ProductsController < ApplicationController
  def index
    #This returns all products that are not retired.
    @products = Product.find_all_by_status('active')
  end

  def show
    @product = Product.find(params[:id])
  end

  # def new
  #   @product = Product.new
  # end

  # def create
  #   @product = Product.new(params[:product])
  #   if @product.save
  #     redirect_to @product, :notice => "Successfully created company."
  #   else
  #     render :action => 'new'
  #   end
  # end

  # def edit
  #   @company = Company.find(params[:id])
  # end

  # def update
  #   @company = Company.find(params[:id])
  #   if @company.update_attributes(params[:company])
  #     redirect_to @company, :notice  => "Successfully updated company."
  #   else
  #     render :action => 'edit'
  #   end
  # end

  # def destroy
  #   @company = Company.find(params[:id])
  #   @company.destroy
  #   redirect_to companies_url, :notice => "Successfully destroyed company."
  # end
end
