module ApplicationHelper

  def get_cart_count
    current_cart ? current_cart.cart_count : 0
  end

end
