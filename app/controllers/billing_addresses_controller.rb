class BillingAddressesController < ApplicationController
  def new
    @address = BillingAddress.new
  end

  def create
    @address = BillingAddress.create(params[:billing_address])
    session[:billing_address] = @address.id
    redirect_to new_transaction_path
  end
end
