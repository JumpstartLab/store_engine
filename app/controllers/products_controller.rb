class ProductsController < ApplicationController
  before_filter :lookup_product, :only => [:show, :edit, :destroy, :update]

  def index
    @products = Product.all
    @line_item = LineItem.new
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        notice = 'Product was successfully created.'
        format.html { redirect_to product_path(@product), notice: notice }
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    Product.destroy(@product)
    redirect_to products_path
  end

  def edit
  end

  def update
    # raise params.inspect
    @product.update_attributes(params[:product])
    redirect_to product_path(@product)
  end

  private

  def lookup_product
    @product = Product.find(params[:id])
  end
end
