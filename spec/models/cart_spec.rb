require 'spec_helper'

describe Cart do
  let(:cart) { Cart.create }
  let(:product_one) { FactoryGirl.create(:product) }
  let(:product_two) { FactoryGirl.create(:product) }
  let(:products) { [ product_one, product_two ] }
  
  context "when items have been added to the cart" do
    before(:each) do
      products.each do |product|
        cart.add_product(product)
      end
    end

    describe "#items" do
      it "returns the items" do
        cart.products.count.should == products.count
        # save_and_open_page
        products.each do |p|
          cart.products.should include(p)
        end
      end
    end

    describe "#cart_count" do
      it "should return the number of items added" do
        cart.cart_count.should == products.size
      end
    end

    describe "#cart_total" do
      it "should return the total" do
        cart.cart_total.should == products.map(&:price).inject(:+)
      end
    end

    describe "#cart_total_in_cents" do
      it "should return the total in cents" do
        cart.cart_total_in_cents.should == products.map(&:price).inject(:+) * 100
      end
    end

    describe "#is_empty?" do
      it "returns false" do
        cart.is_empty? == false
      end
    end

  end

  context "when no items have been added to the cart" do
    describe "#cart_total" do
      it "should return 0" do
        cart.cart_total.should == 0
      end
    end

    describe "#cart_total_in_cents" do
      it "should return 0" do
        cart.cart_total.should == 0
      end
    end

    describe "#cart_count" do
      it "should return 0" do
        cart.cart_count.should == 0
      end
    end

    describe "#is_empty?" do
      it "returns true" do
        cart.is_empty? == true
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

  describe "#assign_cart_to_user" do
    let!(:user) { FactoryGirl.create(:user) }

    context "when the cart has no products in it" do
      # it "destroys the cart" do
      #   cart.assign_cart_to_user(user)
      #   Cart.all.should be_empty
      # end
    end

    context "when the cart has products in it" do
      before(:each) do
        products.each do |product|
          cart.add_product(product)
        end
      end

      context "if the user has no existing carts" do
        it "gives the cart to the user" do
          user.cart.should == nil
          cart.assign_cart_to_user(user)
          user.cart.should == cart
        end
      end

      context "if the user has an existing cart" do
        let!(:user_cart) { FactoryGirl.create(:cart) }
        before(:each) { user.cart = user_cart }
        context "and the new cart has products in it"
          it "should replace the existing cart" do
            user.cart.should_not == nil
            cart.assign_cart_to_user(user)
            user.cart.should_not == user_cart
            Cart.find_by_id(user_cart.id).should == nil
          end
        context "and the new cart does not have products in it" do
          let!(:new_cart) { FactoryGirl.create(:cart, :user_id => nil) }

          it "should not replace the existing cart" do
            new_cart.assign_cart_to_user(user)
            user.cart.should == user_cart
          end
        end
      end
    end
  end
end
