class BillingAddressesController < ApplicationController
  def new
    @billing_address = BillingAddress.new
  end

  def create
    @billing_address = BillingAddress.new(params[:billing_address])
    if @billing_address.save
      current_user.billing_address = @billing_address
      current_user.save
      same_shipping_address(params)
    else
      render :action => "new"
    end
  end

  def edit
    @billing_address = current_user.billing_address
  end

  def update
    @billing_address = current_user.billing_address
    @billing_address.update_attributes(params[:billing_address])
    redirect_to order_summary_path
  end

  private

  def same_shipping_address(params_hash)
    if params_hash[:same_as_shipping_address] == "1"
      current_user.shipping_address =
        ShippingAddress.new(params[:billing_address])
      current_user.save
      redirect_to new_transaction_path
    else
      redirect_to new_shipping_address_path
    end
  end
end
