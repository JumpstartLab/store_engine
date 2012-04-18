# == Schema Information
#
# Table name: categories
#
#  id                  :integer         not null, primary key
#  product_category_id :integer
#  name                :string(255)
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#

Fabricator(:category) do
  name Faker::Name.first_name + sequence.to_s
end
