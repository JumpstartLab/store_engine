module ApplicationHelper
  def cart_count
    Cart.new(session[:cart]).count
  end
end
