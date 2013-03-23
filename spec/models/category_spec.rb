require File.dirname(__FILE__) + '/../spec_helper'

describe Category do
  let(:category1) {Category.create(title:'Things')}

  it "should be valid" do
    expect(category1).to be_valid
  end

  it "should not be valid without a title" do
    category1.title = ""
    expect(category1).to_not be_valid
  end
end
