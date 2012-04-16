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

  describe ".find_by_title" do
    let!(:product) { FactoryGirl.create(:product, title: "Lightsaber") }
    it "returns a match with the exact string" do
      p = Product.find_by_title(product.title)
      p.first.title.should == product.title
    end

    it "returns a match with the lowercase string" do
      p = Product.find_by_title("lightsaber")
      p.first.title.should == product.title
    end
  end

  describe ".find_by_category" do
    let(:category) { FactoryGirl.create(:category) }
    let!(:product) { FactoryGirl.create(:product, categories: [category]) }
    it "returns a match with the exact string" do
      p = Product.find_by_category(category.title)
      p.first.title.should == product.title
    end

    it "returns a match with the lowercase string" do
      p = Product.find_by_category(category.title.downcase)
      p.first.title.should == product.title
    end
  end

  describe "#status" do
    let(:product) { FactoryGirl.create(:product, :activity => false) }
    let(:product_2) { FactoryGirl.create(:product) }
    it "returns false if the item is retired" do
      product.status?.should be_false
    end

    it "returns true for new items" do
      product_2.should be_true
    end
  end
end


# ttr_accessible :title, :description, :activity, :price, :image_link