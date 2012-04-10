# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :product do
    sequence(:name) { |n| "Mitten #{n}" }
    description "A very well-crafted mitten."
    price_cents 1500
    photo "http://www.wearyourbeer.com/images/David_Goliath_Weenie_Protect_Blue_Shirt2.jpg"
    status "active"
  end
end
