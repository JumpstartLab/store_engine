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

  it "can be created with a blank price" do
    product.price = ""
    product.should_not be_valid
  end

  it "must have a unique title" do
    product2 = Product.new(:title => product.title,
      :description => product.description)
    product2.should_not be_valid
  end

  context "price" do
    it "must be a number" do
      product.price = 'puppy'
      product.should_not be_valid
    end

    it "can't be negative" do
      product.price = -123.45
      product.should_not be_valid
    end
  end

  it "must have a URL photo" do
    product.photo = "awesome"
    product.should_not be_valid
  end

  it "is cleaned when saved" do
    product.price = "34.567"
    product.save
    product.price.to_s.should == "34.56"
  end
end