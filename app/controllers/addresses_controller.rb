class AddressesController < ApplicationController
  def create
    # raise params.inspect
    user = User.find_by_id(params[:user_id])
    address = user.addresses.new(params[:address])
    user.save
    if params[:type] == "billing"
      user.set_default_billing_address_by_id(address.id)
    elsif params[:type] == "shipping"
      user.set_default_shipping_address_by_id(address.id)
    end
    redirect_to(:back)
  end

end
