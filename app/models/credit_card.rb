class CreditCard < ActiveRecord::Base
  attr_accessible :credit_card_type, :last_four, :exp_month, :exp_year, :stripe_customer_token, :user_id
  validates_presence_of :user_id
  belongs_to :user

  def initialize(user)
    super()
    self.user_id = user.id
  end

  def add_details_from_stripe_card_token(stripe_card_token)
    stripe_customer_token = stripe_get_customer_token(stripe_card_token)
    credit_card = parse_stripe_customer_token(stripe_customer_token)
  end

  def stripe_get_customer_token(stripe_card_token)
    Stripe::Customer.create( description: "Mittenberry Customer ##{user.id}",
                                      card: stripe_card_token)

  rescue Stripe::InvalidRequestError => e
    send_customer_create_error(e)
  end

  def charge(cart_total_in_cents)
    Stripe::Charge.create(amount: cart_total_in_cents,
                          currency: 'usd',
                          customer: stripe_customer_token)
  rescue Stripe::InvalidRequestError => e
    send_charge_error(e)
  end

private

  def parse_stripe_customer_token(customer_token)
    self.stripe_customer_token = user.id
    card_details = customer_token["active_card"]
    self.last_four = card_details[:last4]
    self.credit_card_type = card_details[:type]
    self.exp_month = card_details[:exp_month]
    self.exp_year = card_details[:exp_year]

    save
  end

  def send_charge_error(e)
    logger.error "Stripe error while charging customer: #{e.message}"
    errors.add :base, "There was a problem with the charge."
    false
  end

  def send_customer_create_error(e)
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end


end
