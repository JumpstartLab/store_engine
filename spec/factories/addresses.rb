# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    street "MyString"
    zipcode "MyString"
  end
end
