module ShippingAddressesHelper
  def validate_shipping_user
    if @shipping_address.user_id != current_user.id
      redirect_to root_url, notice: "Sorry, you are not allowed to"
      "view that.".squish
      false
    else true
    end
  end
end