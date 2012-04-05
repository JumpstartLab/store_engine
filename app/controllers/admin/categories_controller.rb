class Admin::CategoriesController < ApplicationController
  before_filter :require_login
  before_filter :require_admin

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
    @category.name  = params[:category][:name]
    if @category.save
      redirect_to :action => 'show', :id => @category
    else
      @categories = Category.all
      render :action => 'edit'
    end
  end
end
