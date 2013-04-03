module RatingsHelper
  def average_rating(ratings)
    stars = ratings.map { |rating| rating.stars }.inject(&:+)
    ((BigDecimal.new(stars) / BigDecimal.new(ratings.count)) * 2).round / 2.0
  end

  def user_purchased?(user, product)
    orders = Order.where(user_id: user.id).includes(:products)
    orders.select { |order| order.products.include?(product) }.present?
  end

  def user_rating(user, ratings)
    rating = ratings.select { |rating| rating.user_id == user.id }
    rating ? rating.first : false
  end
end
