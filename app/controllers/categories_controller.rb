class CategoriesController < ApplicationController
  
  before_filter :admin_authorize

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
    redirect_to categories_path, notice: "Categories all the way down!"
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      redirect_to category_path(@category), :notice => "Category updated."
    else
      render 'edit'
    end
  end

end
