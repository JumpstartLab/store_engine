class CheckoutController < ApplicationController

  def show
    if current_user == false
      redirect_to login_path
    else
      prefill_addresses
    end
  end

  private

  def prefill_addresses
    if current_user.billing_address.nil?
      redirect_to new_billing_address_path
    elsif current_user.shipping_address.nil?
      redirect_to new_shipping_address_path
    else
      redirect_to order_summary_path
    end
  end
end
