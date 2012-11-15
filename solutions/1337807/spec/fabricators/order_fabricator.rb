# == Schema Information
#
# Table name: orders
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  status     :string(255)
#  address_id :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

Fabricator(:order) do
  user_id 1
  status ["pending", "cancelled", "paid", "shipped", "returned"].sample
end
