class BillingAddressesController < ApplicationController
  def new
    @address = BillingAddress.new
  end

  def create
    @address = BillingAddress.new(params[:billing_address])
    if @address.save
      session[:billing_address] = @address.id
      redirect_to order_summary_path
    else
      render :action => "new"
    end
  end
end
