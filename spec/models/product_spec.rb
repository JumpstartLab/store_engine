require 'spec_helper'

describe Product do
  before(:each) do
    @attr = {
      title: "Shoe",
      description: "It's a large red shoe. You can live in it.",
      activity: true,
      price: 400,
      image_link: "http://images.apple.com/v20120321121044/startpage/images/promo_resolutionary.jpg"
    }
  end

  it "creates a new product given valid attributes" do
    Product.create!(@attr)
  end

  it "requires a title" do
    no_name_product = Product.new(@attr.merge(title: ""))
    no_name_product.should_not be_valid
  end

  it "requires a description" do
    no_description_product = Product.new(@attr.merge(description: ""))
    no_description_product.should_not be_valid
  end

  it "has a price that is a number" do
    non_numeric_product = Product.new(@attr.merge(price: "hello"))
    non_numeric_product.should_not be_valid
  end

  it "has a price greater than 0" do
    non_numeric_product = Product.new(@attr.merge(price: -3))
    non_numeric_product.should_not be_valid
  end

  it 'rejects duplicate titles' do
    Product.create!(@attr)
    product_with_duplicate_title = Product.new(@attr)
    product_with_duplicate_title.should_not be_valid
  end
end


# ttr_accessible :title, :description, :activity, :price, :image_link