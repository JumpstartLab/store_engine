require File.dirname(__FILE__) + '/../spec_helper'

describe Category do
  before(:each) do
    @category = Category.new(title: "Moldy cheeses")
  end

  it "should be valid" do
    expect(@category).to be_valid
  end

  it "should not be valid without a title" do
    @category.title = ""
    expect(@category).to_not be_valid
  end

  it "should not be valid if title already exists (case insensitive)" do
    @category.save
    category = Category.new(title: "moldy cheeses")
    expect(category.valid?).to be_false
  end
end
