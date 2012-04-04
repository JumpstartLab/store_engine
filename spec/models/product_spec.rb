require 'spec_helper'

#### FINISH WRITING THESE TESTS
describe Product do
  context "when changing a product" do
    describe "#validates_presence_of" do
      it "saves the product when all parameters exist" do
        Product.create(title: "fake title", description: "fake description", price: 5).should be_valid
      end
      it "doesn't save the product when all parameters are not valid" do
        Product.create(title: "", description: "fake description", price: 5).should_not be_valid
        Product.create(title: "fake title", description: "", price: 5).should_not be_valid
        Product.create(title: "fake title", description: "fake description", price: "").should_not be_valid
      end
    end
  end
end