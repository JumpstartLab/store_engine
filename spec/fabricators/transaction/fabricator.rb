require 'credit_card'

Fabricator(:transaction) do
  credit_card_number  { Faker::CreditCard.visa }
  expiration_month    { rand(1...12) }
  expiration_year     { rand(1...12) }
  credit_card_verification_number { Faker::CreditCard.cvv }
  cardholder_name     { Faker::Name.name }
  status              { "success"}
end
