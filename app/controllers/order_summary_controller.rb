class OrderSummaryController < ApplicationController
  def show
    @shipping_address = ShippingAddress.find(session[:shipping_address])
    @billing_address = BillingAddress.find(session[:billing_address])
  end
end
