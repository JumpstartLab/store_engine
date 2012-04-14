# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    street_1 "MyString"
    street_2 "MyString"
    zipcode 1
    city "MyString"
    state "MyString"
    user_id 1
  end
end
