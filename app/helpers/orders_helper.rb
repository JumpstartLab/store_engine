module OrdersHelper
  def current_order
    return Order.find(session[:order_id]) if session[:order_id]
  end
  def require_order_user_or_admin
    if order_does_not_belong_to_user && !admin_view?
      redirect_to root_url, notice: "Sorry, you are not allowed to view that."
    end
  end
end


private

def order_does_not_belong_to_user
  current_order.nil? && (current_user.nil? || @order.user != current_user)
end