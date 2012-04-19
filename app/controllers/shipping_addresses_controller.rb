class ShippingAddressesController < ApplicationController
  def new
    @shipping_address = ShippingAddress.new
  end

  def create
    @shipping_address = ShippingAddress.new(params[:shipping_address])
    if @shipping_address.save
      session[:shipping_address] = @shipping_address.id
      current_user.shipping_address = @shipping_address
      current_user.save
      redirect_to new_transaction_path
    else
      render :action => "new"
    end
  end

  def edit
    @shipping_address = current_user.shipping_address
  end

  def update
    @shipping_address.update_attributes(params[:shipping_address])
    redirect_to order_summary_path
  end
end
