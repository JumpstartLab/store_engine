class Admin::CategoriesController < ApplicationController
  before_filter :require_login
  before_filter :require_admin
  before_filter :skip_cart
  
  def new
    @category = Category.new
  end

  def create
    @category = Category.create(params[:category])
    redirect_to action: :index
  end

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.name = params[:category][:name]
    if @category.save
      redirect_to :action => 'show', :id => @category
    else
      @categories = Category.all
      render :action => 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to action: :index
  end
end
