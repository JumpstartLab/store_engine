# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  sequence(:name) { |n| "Mitten #{n}" }

  factory :product do
    name
    description "A very well-crafted mitten."
    price_cents 1500
    photo "http://www.wearyourbeer.com/images/David_Goliath_Weenie_Protect_Blue_Shirt2.jpg"
    status "active"
  end
end
