class CreditCard < ActiveRecord::Base
  attr_accessible :credit_card_type, :last_four, :exp_month, :exp_year, :stripe_customer_token, :user_id
  validates_presence_of :user_id
  belongs_to :user

  def self.create_from_stripe_token(customer_token)
    credit_card = parse_stripe_customer_token(customer_token)
    credit_card
  end

  def charge(cart_total_in_cents)
    Stripe::Charge.create(amount: cart_total_in_cents,
                          currency: 'usd',
                          customer: stripe_customer_token)
  rescue Stripe::InvalidRequestError => e
    send_charge_error(e)
  end

  def add_user_to_credit_card(user)
    self.user = user
    save
  end

private

  def self.parse_stripe_customer_token(customer)
    CreditCard.new(  :stripe_customer_token => customer.id,
                     :last_four => customer.active_card[:last4],
                     :credit_card_type => customer.active_card[:type],
                     :exp_month => customer.active_card[:exp_month],
                     :exp_year => customer.active_card[:exp_year] )
  end

  def send_charge_error(e)
    logger.error "Stripe error while charging customer: #{e.message}"
    errors.add :base, "There was a problem with the charge."
    false
  end

end
