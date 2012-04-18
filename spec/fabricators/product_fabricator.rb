# == Schema Information
#
# Table name: products
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :text
#  price       :integer
#  photo       :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

Fabricator(:product) do
  title { Faker::Lorem.words(rand(5..10)).map(&:capitalize).join(" ") + sequence.to_s }
  description { Faker::Lorem.paragraph }
  price {"#{rand(10..99)}.#{rand(10..99)}"}
  photo { Faker::Internet.url }
end
