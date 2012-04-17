require 'spec_helper'

describe Category do
  describe "#to_param" do
    it "returns the dom_id of the category" do
      c = Fabricate(:category)
      c.to_param.should == "#{c.id}-#{c.name.downcase.gsub(" ","-")}"
    end
  end

  describe "#image" do
    it "returns the image of the first product of the category" do
      category = Fabricate(:category)
      prod1 = Fabricate(:product)
      prod2 = Fabricate(:product)
      prod1.categories << category
      prod2.categories << category
      category.image.should == prod1.image
    end
  end

end
