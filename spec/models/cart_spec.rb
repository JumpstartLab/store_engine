require 'spec_helper'

describe Cart do
  let(:cart) { Cart.create }
  let(:product) { Fabricate(:product) }
  let (:products) { [product, Fabricate(:product)] }

  describe "#items" do
    context "when items have been added to the cart" do
      before(:each) { products.each { |p| cart.add_product(p) } }

      it "returns the products" do
        cart.products.count.should == products.count
        products.each do |p|
          cart.products.should include(p)
        end
      end
    end
  end

  describe "#add_product_by_id" do
    it "adds a product to the cart" do
      expect {
        cart.add_product_by_id(product.id)
      }.to change { cart.products.count }.by(1)
    end
  end
end
