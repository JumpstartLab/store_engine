class Admin::SalesController < ApplicationController
  before_filter :require_admin

  def index
    @sales = Sale.all
  end

  def new
    @sale = Sale.new
    @products = Product.all
    @categories = Category.all
  end

  def create
    foreign_key = params[:foreign_key].tr('^0-9', '').to_i
    group = params[:foreign_key].tr('^A-Za-z', '')
    percent_off = params[:percent_off].to_i
    @sale = Sale.new(foreign_key: foreign_key, group: group, percent_off: percent_off, status: 'active')
    if @sale.save
      redirect_to admin_sales_path, :notice => "Successfully created sale."
    else
      @products = Product.all
      @categories = Category.all
      render :action => 'new', :notice  => "Sale creation failed."
    end
  end

  def edit
    @sale = Sale.find(params[:id])
    @products = Product.all
    @categories = Category.all
  end

  def end
    @sale = Sale.find(params[:id])
    if @sale.end
      redirect_to admin_sales_path, :notice  => "Successfully ended sale."
    else
      head 400
    end
  end

  def activate
    @sale = Sale.find(params[:id])
    if @sale.activate
      redirect_to admin_sales_path, :notice  => "Successfully activated sale."
    else
      head 400
    end
  end

  def destroy
    @sale = Sale.find(params[:id])
    @sale.destroy
    redirect_to admin_sales_url, :notice => "Successfully destroyed sale."
  end
end
