class SalesController < ApplicationController
  def new
    @sale = Sale.new
  end

  def create
    create_sale_from_params
    if @sale.save
      set_product_or_category
      redirect_with_params
    else
      render :action => 'create', :notice => "Something went wrong."
    end
  end

  def show
    @sale = Sale.find(params[:id])
  end

private
  def set_product_or_category
    if params[:sale][:product_id]
      set_product_from_params
    elsif params[:sale][:category_id]
      set_category_from_params
    end
  end

  def create_sale_from_params
    @sale = Sale.new
    @sale.endtime = params[:sale][:endtime]
    @sale.percentage = params[:sale][:percentage]
  end

  def set_product_from_params
    product = Product.find(params[:sale][:product_id])
    product.sale = @sale
    product.save
  end

  def set_category_from_params
    category = Category.find(params[:sale][:category_id])
    category.sale = @sale
    category.save
  end

  def redirect_with_params
    params[:sale] = @sale.to_param
    redirect_to sale_path(@sale)
  end
end
