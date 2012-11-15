require 'spec_helper'

describe Category do
  let(:category) do
    FactoryGirl.create(:category)
  end
  it "Destroys a category" do
    category.destroy
    category.active.should == 0
  end
end
