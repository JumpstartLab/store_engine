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
