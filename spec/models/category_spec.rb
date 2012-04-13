require 'spec_helper'

describe Category do
  before(:each) do
    @attr = {
      title: "Shoes"
    }
  end
  
  it "creates a new category given valid attributes" do
    Category.create!(@attr)
  end
  
  it "requires a title" do
    no_title_category = Category.new(@attr.merge(title: ""))
    no_title_category.should_not be_valid
  end
end
