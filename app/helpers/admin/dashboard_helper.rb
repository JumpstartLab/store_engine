module Admin::DashboardHelper

  def orders_by_status(status)
    Order.find_all_by_status(status).count
  end

end
