require 'spec_helper'

describe Product do
  let(:product) { Fabricate :product }

  it "can't be created with a blank title" do
    product.title = ""
    product.should_not be_valid
  end

  it "can't be created with a blank description" do
    product.description = ""
    product.should_not be_valid
  end

  it "creates with a 0 price if price is blank" do
    product.price = ""
    product.price.should == 0
  end

  it "must have a URL photo" do
    product.photo = "awesome"
    product.should_not be_valid
  end

  it "rounds correctly" do
    product.update_attributes(:price => "34.567")
    Product.find(product.id).price.to_s.should == "34.57"
  end
end
