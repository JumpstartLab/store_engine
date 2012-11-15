Fabricator(:product) do
  title { Faker::Lorem.words(num=1).join("").capitalize }
  description { Faker::Lorem.sentence }
  price { rand(75) + 1 }
  image { "" }
  remote_image_url {""}
end
