class Cart < ActiveRecord::Base
  attr_accessible :current_cart

  belongs_to :user
  has_many :cart_products
  has_many :products, :through => :cart_products

  def add_product(id)
    p = Product.find(id)
    if products.include? p
      with_cart_product_id(p.id).update_quantity
    else
      products << p
    end
  end

  def remove_product(id)
    products.delete(Product.find(id))
  end

  def add_user(current_user)
    user = current_user if current_user
  end

  def with_cart_product_id(id)
    cart_products.where(:product_id => id).first
  end

  def total_in_cart
    cart_products.sum(&:total_for_product)
  end

  def total_in_dollars
    Money.new(total_in_cart).format
  end

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

end
