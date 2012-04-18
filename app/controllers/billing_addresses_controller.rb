class BillingAddressesController < ApplicationController
  def new
    @address = BillingAddress.new
  end

  def create
    @address = BillingAddress.new(params[:billing_address])
    if @address.save
      session[:billing_address] = @address.id
      current_user.billing_address = @address
      redirect_to new_transaction_path
    else
      render :action => "new"
    end
  end
end
