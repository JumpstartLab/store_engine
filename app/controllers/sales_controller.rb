class SalesController < ApplicationController
  before_filter :find_sale, :only => [:edit, :update, :destroy, :show]
  before_filter :require_admin, :only => [:new, :create, :destroy, :edit, :update, :admin_index]

  def index
    @sales = Sale.all
  end

  def admin_index
    @sales = Sale.all  
  end

  def new
    @sale = Sale.new  
  end

  def edit
    
  end

  def show
    
  end

  def update
    if @sale.update_attributes(params[:sale])
    redirect_to sale_path(@sale), :notice => "Sale updated."
    else
      render 'edit'
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
