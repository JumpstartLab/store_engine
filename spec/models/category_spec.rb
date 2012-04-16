require 'spec_helper'

describe Category do
  describe "#to_param" do
    it "returns the dom_id of the category" do
      category = Fabricate(:category)
      category.to_param.should == "#{category.id}-#{category.name.downcase.gsub(" ","-")}"
    end
  end

end
