module Search
  def self.filter_products(params = {})
    if params[:category_id].present?
      Category.find(params[:category_id]).products.where(status: 'active')
    elsif params[:search].present?
      Product.where("title LIKE ? OR description LIKE ? AND status = ?",
                    "%#{params[:search]}%",
                    "%#{params[:search]}%",
                    "active")
    else
      Product.find_all_by_status('active')
    end
  end

  def self.filter_user_orders(user_id, params={})
    orders = Order.where(user_id: user_id).all
    if params[:search].present?
      products = Product.where("title LIKE ? OR description LIKE ?",
                               "%#{params[:search]}%",
                               "%#{params[:search]}%")
      orders.select { |order| (order.products & products).present? }
      #  Order.find_by_sql <<-SQL
      #    SELECT *
      #    FROM orders
      #    INNER JOIN order_items ON order_items.order_id = orders.id
      #    INNER JOIN products ON products.id = order_items.product_id
      #    WHERE orders.user_id = #{user_id}
      #      AND (products.title LIKE %#{query_term}% OR products.description LIKE %#{query_term}%)
      #  SQL
    else
      orders
    end
  end

  def self.filter_admin_orders(params={})
    order = Order.includes(:user)
    if params[:status].present? && params[:status] != 'all'
      order = order.where(status: params[:status])
    end
    if params[:date_symbol].present? && params[:date].present?
      order = order.where("orders.created_at #{params[:date_symbol]} ?", params[:date])
    end
    if params[:email].present?
      order = order.where("email = ?", params[:email])
    end
    orders = order.all
    if params[:price_symbol].present? && params[:price].present?
      orders = orders.select { |order| order.total > (BigDecimal.new(params[:price]) / 100) }
    end
    orders
  end
end
