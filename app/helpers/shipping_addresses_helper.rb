module ShippingAddressesHelper
  def validate_shipping_user
    if @shipping_address.user_id.nil?
      if shipping_address_order != current_order
        redirect_to root_url, notice: "Sorry, you are not allowed to"
          "view that.".squish
        false
      else true
      end
    else
      if @shipping_address.user_id != current_user.id
        redirect_to root_url, notice: "Sorry, you are not allowed to"
           "view that.".squish
        false
      else true
      end
    end
  end
end

private

def shipping_address_order
  Order.find_by_shipping_address_id(@shipping_address.id)
end