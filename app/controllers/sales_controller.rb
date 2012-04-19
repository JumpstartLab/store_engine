class SalesController < ApplicationController
  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new
    @sale.endtime = params[:sale][:endtime]
    @sale.percentage = params[:sale][:percentage]

    if @sale.save
      if params[:sale][:product_id]
        product = Product.find(params[:sale][:product_id])
        product.sale = @sale
        product.save
      elsif params[:sale][:category_id]
        category = Category.find(params[:sale][:category_id])
        category.sale = @sale
        category.save
      end
      params[:sale] = @sale.to_param
      redirect_to sale_path(@sale)
    else
      render :action => 'create', :notice => "Something went wrong."
    end
  end

  def show
    @sale = Sale.find(params[:id])
  end
end
