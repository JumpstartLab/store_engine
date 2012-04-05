require 'spec_helper'

describe Cart do
  let(:cart) { Cart.create }
  let(:product) { Fabricate(:product) }
  let (:products) { [product, Fabricate(:product)] }

  describe "#items" do
    context "when items have been added to the cart" do
      before(:each) { products.each { |p| cart.add_item(p) } }

      it "returns the items" do
        cart.items.count.should == products.count
        products.each do |p|
          cart.items.should include(p)
        end
      end
    end
  end

  describe "#add_product_by_id" do
    it "adds a product to the cart" do
      expect {
        cart.add_product_by_id(product.id)
      }.to change { cart.items.count }.by(1)
    end
  end
end
