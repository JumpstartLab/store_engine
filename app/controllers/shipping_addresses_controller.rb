class ShippingAddressesController < ApplicationController
  def new
    @address = ShippingAddress.new
  end

  def create
    @address = ShippingAddress.create(params[:shipping_address])
    redirect_to new_billing_address_path
  end
end
