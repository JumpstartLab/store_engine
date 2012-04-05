# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    name "T-Shirt"
    description "A blue shirt"
    price 1500
    photo "http://www.wearyourbeer.com/images/David_Goliath_Weenie_Protect_Blue_Shirt2.jpg"
    status "active"
  end
end
