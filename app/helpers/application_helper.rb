module ApplicationHelper
  def cart_count
    count = session[:cart].values.map(&:to_i).reduce(&:+) if session[:cart]
    count ? "(#{count})" : nil
  end
end
