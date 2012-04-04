Fabricator(:product, :class_name => "Product") do
  id { sequence }
  title { Faker::Lorem.words(1).join }
  description { Faker::Lorem.words(10).join(" ") }
end