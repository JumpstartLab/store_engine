require 'spec_helper'

describe Product do

  [:title, :description, :price].each do |attr|
    it "has an attribute #{attr}" do
      Product.new.should respond_to(attr)
    end
  end

  context "valid attributes" do
    let(:product) { Fabricate(:product) }

    context "presence of" do
      it "is valid with valid attributes and a nil photo url" do
        product.should be_valid
      end

      it "is not valid without a title" do
        product.title = nil
        product.should_not be_valid
      end

      it "is not valid without a description" do
        product.description = nil
        product.should_not be_valid
      end

      it "is not valid without a price" do
        product.price = nil
        product.should_not be_valid
      end
    end

    context "type validations" do
      it "does not allow a duplicate title to be created" do
        prod_1 = {title: "a", description: "b", price: 5}
        prod_2 = {title: "a", description: "c", price: 6}
        Product.create(prod_1)
        Product.create(prod_2).should_not be_valid
      end

      it "is not valid with a non-numerical price" do
        product.price = "string"
        product.should_not be_valid
      end


      it "accepts a valid photo_url" do
        product.photo_url = "http://blah.com/blah.jpg"
        product.should be_valid
      end

      it "does not accept an invalid photo_url" do
        product.photo_url = "blah"
        product.should_not be_valid
      end
    end
  end
  describe "display_price" do
    let(:product) { Fabricate(:product) }
    it "takes a float and returns a big decimal with 2 decimal places" do
      product.display_price.should == BigDecimal.new(product.price,2)
    end
  end
end