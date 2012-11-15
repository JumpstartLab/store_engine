# Restful actions for products
class Admin::ProductsController < AdminController

  def index
    @products = Product.where(:active => 1).paginate(:page => params[:page])
    @categories = Category.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save()
      redirect_to product_path(@product), :notice => "Product created."
    else
      render 'new'
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to products_path, :notice => "Product Removed"
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      redirect_to product_path(@product), :notice => "Product updated."
    else
      render 'edit'
    end
  end

end
