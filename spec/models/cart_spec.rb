require 'spec_helper'

describe Cart do
  let(:cart) { Cart.create }
  let(:product) { FactoryGirl.create(:product) }
  let(:products) { [product, product] }
  
  describe "#items" do
    context "when items have been added to cart" do

      before(:each) do
        products.each do |product|
          cart.add_item(product)
        end
      end

      it "returns items" do
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
