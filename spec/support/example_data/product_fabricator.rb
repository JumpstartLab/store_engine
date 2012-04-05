Fabricator(:product, :class_name => Product) do
  title { Faker::Lorem.words(1).join }
  description { Faker::Lorem.words(1).join }
  price { BigDecimal.new((rand * 100), 2) }
  photo_url { nil }

end