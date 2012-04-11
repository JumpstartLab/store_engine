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

  describe "#cart_count" do
    context "when no items have been added to the cart" do
      it "should return 0" do
        cart.cart_count.should == 0
      end
    end

    context "when items have been added to the cart" do
      before do
        products.each do |product|
          cart.add_product(product)
        end
      end

      it "should return the number of items added" do
        cart.cart_count.should == products.size
      end
    end
  end

  describe "#cart_total" do
    context "when no items have been added to the cart" do
      it "should return 0" do
        cart.cart_total.should == 0
      end
    end

    context "when items have been added to the cart" do
      before do
        products.each do |product|
          cart.add_product(product)
        end
      end

      it "should return the number of items added" do
        cart.cart_total.should == products.map(&:price).inject(:+)
      end
    end
  end

  describe "#cart_total_in_cents" do
    context "when no items have been added to the cart" do
      it "should return 0" do
        cart.cart_total.should == 0
      end
    end

    context "when items have been added to the cart" do
      before do
        products.each do |product|
          cart.add_product(product)
        end
      end

      it "should return the number of items added" do
        cart.cart_total_in_cents.should == products.map(&:price).inject(:+) * 100
      end
    end
  end

  describe "#has_products?" do
    context "when no items have been added to the cart" do
      it "should return true" do
        cart.has_products?.should == false
      end
    end

    context "when items have been added to the cart" do
      before do
        cart.add_product(product_one)
      end

      it "should false" do
        cart.has_products?.should == true
      end
    end
  end

  describe "#remove_product_by_id" do
    before(:each) do
      products.each do |product|
        cart.add_product(product)
      end
    end

    it "removes a product from a cart" do
      cart.products.count == products.count
      expect {
        cart.remove_product_by_id(product_one.id)
      }.to change { cart.products.count }.by(-1)
    end
  end

  describe "#add_product_by_id" do
    it "adds a product to the cart" do
      expect {
        cart.add_product_by_id(product_one.id)
      }.to change { cart.products.count }.by(1)
    end

    context "adds a second item to the cart" do
      it "does not add an additional cart_product" do
        cart.add_product_by_id(product_one.id)
        expect {
          cart.add_product_by_id(product_one.id)
        }.to_not change { cart.products.count }.by(1)
      end

      it "increases the quantity" do
        cart.add_product_by_id(product_one.id)
        expect {
          cart.add_product_by_id(product_one.id)
        }.to change { cart.cart_products.find_by_product_id(product_one.id).quantity }.by(1)
      end
    end
  end

end
