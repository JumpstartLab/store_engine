# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  sequence :p_name do |n|
    "Product#{n}"
  end

  factory :product do
    name "Mitten"
    description "A very well-crafted mitten."
    price_cents 1500
    photo "http://www.wearyourbeer.com/images/David_Goliath_Weenie_Protect_Blue_Shirt2.jpg"
    status "active"
  end
end
