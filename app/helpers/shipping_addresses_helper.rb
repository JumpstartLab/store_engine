module ShippingAddressesHelper
  def validate_shipping_user
    if @shipping_address.user_id.nil?
      if Order.find_by_shipping_address_id(@shipping_address.id) != current_order
        redirect_to root_url, notice: "Sorry, you are not allowed to view that."
        false
      else true
      end
    else
      if @shipping_address.user_id != current_user.id
        redirect_to root_url, notice: "Sorry, you are not allowed to view that."
        false
      else true
      end
    end
  end
end