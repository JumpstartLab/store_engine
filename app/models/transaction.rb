class Transaction < ActiveRecord::Base
  belongs_to :user

  attr_accessible :stripe_card_token

  # def save_with_payment
  #   if valid?
  #     customer = Stripe::Customer.create(card: stripe_card_token)
  #     self.stripe_customer_token = customer.id
  #     save!
  #   end
  # end
end
