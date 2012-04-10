# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :advanced_search do
    status_id 1
    order_total 1
    order_date "2012-04-10"
    email "MyString"
  end
end
