Fabricator(:product) do
  name { sequence(:name) { |i| "Sample Product #{i}" } }
  categories
  description "Sample description"
  photo_url "https://www.google.com/images/srpr/logo3w.png"
  price_in_cents 400
end