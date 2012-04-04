# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :discount do
    product_id 1
    category_id 1
    percentage 1
  end
end
