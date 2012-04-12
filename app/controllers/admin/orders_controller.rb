class Admin::OrdersController < Admin::AdminController
  def show
    @order = Order.find(params[:id])
  end

end
