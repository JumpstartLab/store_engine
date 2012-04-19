class OrderSummaryController < ApplicationController
  def show
    @shipping_address = current_user.shipping_address
    @billing_address = current_user.billing_address
  end
end
