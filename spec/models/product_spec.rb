require 'spec_helper'

describe Product do

  describe "#set_categories" do
    context "When adding categories to a product" do
          let!(:product) { Fabricate(:product) }
      let!(:category) { Fabricate(:category) }
      let!(:category2) { Fabricate(:category) }

      it "sets a category" do
        product.categories.length.should == 0
        product.set_categories([category.id])
        product.categories.length.should == 1
        product.categories.include?(category).should == true
      end

      it "sets unique categories" do
        product.set_categories([category.id, category.id])
        product.categories.length.should == 1
      end

      it "sets multiple categories" do
        product.set_categories([category.id, category2.id])
        product.categories.length.should == 2
        product.categories.include?(category).should == true
        product.categories.include?(category2).should == true
      end
    end
  end

  describe "#price" do
    context "when price is 50 cents" do
      it "stores price of 50 cents" do
        product = Product.new(:title => "Foo", :description => "", :price => ".50")
        product.price.should == Money.new(50, "USD")
      end
    end

    context "When price is an empty string" do
      it "stores price as 0.00" do
        product = Product.new(:title => "Foo", :description => "", :price => "")
        product.price.should == Money.new(0, "USD")
      end
    end

    context "When price is $1000" do
      it "stores price as 1000.00" do
        product = Product.new(:title => "Foo", :description => "", :price => "1000")
        product.price.should == Money.new(100000, "USD")
      end
    end

    context "When price is $10.65" do
      it "stores price as 10.65" do
        product = Product.new(:title => "Foo", :description => "", :price => "10.65")
        product.price.should == Money.new(1065, "USD")
      end
    end

    context "When price is $10.0" do
      it "stores price as 10.00"
    #     product = Product.new(:title => "Foo", :description => "", :price => "10.0")
    #     product.price.should == Money.new(1000, "USD")
    #   end
    end
  end

  describe "#display_retired" do
    context "when retired" do
      let!(:product) { Fabricate(:product, :retired => true) }
      it "returns Retired" do
        product.display_retired.should == "Retired"
      end
    end

    context "when not retired" do
      let!(:product) { Fabricate(:product, :retired => false) }
      it "returns Active" do
        product.display_retired.should == "Active"
      end
    end
  end
end
