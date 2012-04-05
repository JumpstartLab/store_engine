require 'spec_helper'

describe Cart do
  let(:cart) { Cart.create }
  let(:product_one) { FactoryGirl.create(:product) }
  let(:product_two) { FactoryGirl.create(:product) }
  let(:products) { [ product_one, product_two ] }
  
  describe "#items" do
    context "when items have been added to the cart" do
      before(:each) do
        products.each do |product|
          cart.add_product(product)
        end
      end

      it "returns the items" do
        cart.products.count.should == products.count
        # save_and_open_page
        products.each do |p|
          cart.products.should include(p)
        end
      end
    end
  end

  describe "add_product_by_id" do
    it "adds a product to the cart" do
      expect {
        cart.add_product_by_id(product_one.id)
      }.to change { cart.products.count }.by(1)
    end
  end

end
