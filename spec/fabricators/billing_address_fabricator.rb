Fabricator(:billing_address, :class_name => "BillingAddress") do
  id { sequence }
  first_name {sequence }
  first_name { Faker::Lorem.words(1).join }
  last_name { Faker::Lorem.words(1).join }
  company { Faker::Lorem.words(1).join }
  line_1 { Faker::Lorem.words(4).join }
  line_2 { Faker::Lorem.words(5).join }
  city { Faker::Lorem.words(5).join }
  state { "HI" }
  zipcode { "20009" }
  phone { "555-555-5555" }
end
