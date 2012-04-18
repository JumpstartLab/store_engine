# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :credit_card do
    credit_card_type "Visa"
    last_four "1234"
    exp_month "05"
    exp_year  "15"
    stripe_customer_token "tok_KM1feeMHDhSgiq"
    default_card false
  end
end
