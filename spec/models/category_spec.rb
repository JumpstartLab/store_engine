require File.dirname(__FILE__) + '/../spec_helper'

describe Category do
  let(:category) {Category.create(title:'Things')}

  it "should be valid" do
    expect(category).to be_valid
  end

  it "should not be valid without a title" do
    category.title = ""
    expect(category).to_not be_valid
  end
end
