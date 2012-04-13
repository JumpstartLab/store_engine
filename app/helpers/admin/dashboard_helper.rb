module Admin::DashboardHelper

  def orders_count_by_status(status)
    Order.find_all_by_status(status).count
  end

end
