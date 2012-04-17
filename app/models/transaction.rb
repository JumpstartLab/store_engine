class Transaction < ActiveRecord::Base
  belongs_to :user

  attr_accessible :stripe_card_token, :stripe_customer_id, :user_id

  # def save_with_payment
  #   if valid?
  #     customer = Stripe::Customer.create(card: stripe_card_token)
  #     self.stripe_customer_token = customer.id
  #     save!
  #   end
  # end
  def save_stripe_customer_id(current_user, customer)
    self.stripe_customer_id = customer.id
    self.user_id = current_user.id
    save!
  end
end
