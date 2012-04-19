#
class ProductsController < ApplicationController
  before_filter :lookup_product,
                :only => [:show, :edit, :destroy, :update, :retire]

  def index
    if admin_view?
      @products = Product.all
    else
      if params[:filtered].present?
        @products = Product.active.where(
          ["title LIKE ?", "%#{params[:filtered]}%"]
          )
      else
        @products = Product.active.all
        @line_item = LineItem.new
      end
    end
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

  def retire
    product = Product.find(params[:id])
    if product.retired?
      product.make_active_again
    else
      product.retire
    end
    redirect_to root_url
  end


  def edit
  end

  def update
    @product.update_attributes(params[:product])
    redirect_to product_path(@product)
  end

  private

  def lookup_product
    @product = Product.find(params[:id])
  end
end
