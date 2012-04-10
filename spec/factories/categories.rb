# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  factory :category do
    sequence(:name) { |n| "Type #{n}" }
  end
end
