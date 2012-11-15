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

require 'spec_helper'

describe Cart do
  let(:cart) { Fabricate(:cart) }
  let(:product) { Fabricate(:product) }

  context "#add_product_by_id" do
    it "adds a product to the cart" do
      cart.add_product_by_id(product.id)
      cart.products.should include product
    end
  end
end
