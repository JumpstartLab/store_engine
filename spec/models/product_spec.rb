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
  describe "#category_ids=" do
    let(:first_cat) { Fabricate(:category) }
    let(:second_cat) { Fabricate(:category) }
    it "creates the category relationships for the product" do
      cat_ids = [first_cat.id, second_cat.id]
      Product.create({title: "a", description: "b", price: 6,
                      category_ids: cat_ids}).should be_valid

      cat_ids.each do |id|
        Product.last.categories.should include Category.find(id)
      end
    end
  end

  describe "#image" do
    let(:product) {Fabricate(:product)}
    context "when there is a photo_url" do
      it "returns the photo_url" do
        image_address = "http://image.com/image.jpg"
        product.update_attribute(:photo_url, image_address)
        product.image.should == image_address
      end
    end
    context "when there is no photo_url" do
      it "returns the logo" do
        product.update_attribute(:photo_url, "")
        product.image.should == "/logo.png"
      end
    end
  end
  describe "#to_param" do
    it "returns the dom_id of the product" do
      p = Fabricate(:product)
      p.to_param.should == "#{p.id}-#{p.title.downcase.gsub(" ","-")}"
    end
  end
end