#
class CategoriesController < ApplicationController
  before_filter :lookup_category, :only => [:show, :edit, :destroy, :update]
  before_filter :require_admin, :except => [:index, :show]


    def index
      @categories = Category.all
    end

    def show
    end

    def new
      @category = Category.new
    end

    def create
      category = Category.new(params[:category])
      category.save
      redirect_to category_path(category)
    end

    def destroy
      Category.destroy(@category)
      redirect_to categories_path
    end

    def edit
    end

    def update
      @category.update_attributes(params[:category])
      redirect_to category_path(@category)
    end

    private

    def lookup_category
      @category = Category.find(params[:id])
      @products = @category.products
    end
end

