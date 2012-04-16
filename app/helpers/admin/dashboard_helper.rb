module Admin::DashboardHelper
  def status_options
    pending = StoreEngine::Status::PENDING
    cancelled = StoreEngine::Status::CANCELLED
    paid = StoreEngine::Status::PAID
    shipped = StoreEngine::Status::SHIPPED
    returned = StoreEngine::Status::RETURNED
    [[pending, pending], [cancelled, cancelled], [paid, paid], 
      [shipped, shipped], [returned, returned]]
  end
end
