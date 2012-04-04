require 'spec_helper'

#### FINISH WRITING THESE TESTS
describe Product do
  # context "when changing a product" do
  #   describe "#validates_presence_of" do
  #     it "saves the product when all parameters exist" do
  #       Product.create(title: "fake title", description: "fake description", price: 5).should be_valid
  #     end
  #     it "doesn't save the product when all parameters are not valid" do
  #       Product.create(title: "", description: "fake description", price: 5).should_not be_valid
  #       Product.create(title: "fake title", description: "", price: 5).should_not be_valid
  #       Product.create(title: "fake title", description: "fake description", price: "").should_not be_valid
  #     end
  #   end
  # end

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
        product.description = nil
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


      it "is accepts a valid photo url" do
        product.photo_url = "http://blah.com/blah.jpg"
        product.should be_valid
      end
    end
  end
end