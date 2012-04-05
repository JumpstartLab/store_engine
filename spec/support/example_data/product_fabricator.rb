Fabricator(:product, :class_name => Product) do
  title { Faker::Lorem.words(1).join }
  description { Faker::Lorem.words(1).join }
  price { (rand * 100).to_i }
  photo_url { nil }

end