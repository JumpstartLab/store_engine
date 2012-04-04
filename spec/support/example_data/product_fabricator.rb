Fabricator(:product, :class_name => Product) do
  title { Faker::Lorem.words(1).join }
  description { Faker::Lorem.words(1).join }
  price { rand * 100 }
  photo_url { nil }
  created_at Time.now
end