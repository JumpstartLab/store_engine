# Administrators can create sales
class Admin::SalesController < AdminController
  before_filter :find_sale, :only => [:edit, :update, :destroy, :show]

  def index
    @sales = Sale.all
  end

  def new
    @sale = Sale.new
  end

  def edit
  end

  def show
  end

  def create
    @sale = Sale.new(params[:sale])
    if @sale.save
      redirect_to sale_path(@sale), :notice => "Sale created."
    else
      flash[:error] = "Please fix the form."
      render 'new'
    end
  end

  def update
    if @sale.update_attributes(params[:sale])
      redirect_to sale_path(@sale), :notice => "Sale updated."
    else
      render 'edit', :notice => "Please fix the form."
    end
  end

  def destroy
    @sale.destroy
    redirect_to sales_path, :notice => "Sale Removed"
  end

private

  def find_sale
    @sale = Sale.find(params[:id])
  end

end
