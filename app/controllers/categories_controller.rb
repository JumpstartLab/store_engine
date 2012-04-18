class CategoriesController < ApplicationController
  def index
    if (params[:category])
      current_category = Category.find_by_title(params[:category])
      if current_category.nil?
        @products = Product.all?
      else
        @products = Category.find_by_title(params[:category])
      end
    else
      @products = Product.all
    end
  end

  def show
    @category = Category.find_by_id(params[:id])
    @products = @category.products
  end

  def new
    @category = Category.new
  end

  def create
    category = Category.new(params[:category])
    category.save
    redirect_to categories_path
  end

  # def filter_by_category
  #   @products = Product.find_all_by(params[:category])
  # end
end
