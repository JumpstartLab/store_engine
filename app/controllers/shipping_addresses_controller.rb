class ShippingAddressesController < ApplicationController
  def new
    @address = ShippingAddress.new
  end

  def create
    @address = ShippingAddress.new(params[:shipping_address])
    if @address.save
      session[:shipping_address] = @address.id
      redirect_to new_billing_address_path
    else
      render :action => "new"
    end
  end
end
