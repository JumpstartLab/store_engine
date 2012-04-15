Fabricator(:product, :class_name => "Product") do
  id { sequence + 10 }
  title { Faker::Lorem.words(1).join  }
  description { Faker::Lorem.words(10).join(" ") }
  price_cents { rand(10000) }
end
