require 'spec_helper'

describe Category do
  describe "#to_param" do
    it "returns the dom_id of the category" do
      c = Fabricate(:category)
      c.to_param.should == "#{c.id}-#{c.name.downcase.gsub(" ","-")}"
    end
  end

end
