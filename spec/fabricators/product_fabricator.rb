Fabricator(:product) do
  title { Faker::Lorem.words(rand(5..10)).map(&:capitalize).join(" ") + sequence.to_s }
  description { Faker::Lorem.paragraph }
  price {"#{rand(10..99)}.#{rand(10..99)}"}
  photo { Faker::Internet.url }
end