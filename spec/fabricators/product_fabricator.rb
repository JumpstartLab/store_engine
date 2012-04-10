Fabricator(:product) do
  title { Faker::Lorem.words(rand(1..3)).map(&:capitalize).join(" ") + sequence.to_s }
  description { Faker::Lorem.paragraph }
  price { (100 * rand).round(2) + 10 }
  photo { Faker::Internet.url }
end