require File.dirname(__FILE__) + '/../spec_helper'

describe Category do
  let(:category) { Category.new(title: "Moldy cheeses") }

  it "should be valid" do
    expect(category).to be_valid
  end

  it "should not be valid without a title" do
    category.title = ""
    expect(category).to_not be_valid
  end

  it "should not be valid if title already exists (case insensitive)" do
    category.save
    category2 = Category.new(title: "moldy cheeses")
    expect(category2.valid?).to be_false
  end
end
