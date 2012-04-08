module ApplicationHelper

  def get_cart_count
    @cart ? @cart.cart_count : 0
  end

end
