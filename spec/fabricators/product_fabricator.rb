Fabricator(:product) do
  title Faker::Lorem.words(rand(1..3)).map(&:capitalize).join(" ")
  description Faker::Lorem.paragraph
  price (100 * rand).round(2)
  photo Faker::Internet.url
end