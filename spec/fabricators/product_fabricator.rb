Fabricator(:product) do
  title { Faker::Lorem.words(1).first }
  description { Faker::Lorem.paragraph }
  price { rand(10000) + 1 }
  photo { "http://portfolio.adigitalnative.com/style/images/th7.jpg" }
  category_ids { nil }
  retired { false }
end