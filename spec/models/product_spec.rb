require File.dirname(__FILE__) + '/../spec_helper'

describe Product do
  before(:each) do
    @product = Product.new(title: "teef", description: "horse t", price: 0.19)
  end

  it "should be valid" do
    expect(@product).to be_valid
  end

  it "should not be valid without a title" do
    @product.title = ""
    expect(@product).to_not be_valid
  end

  it "should not be valid if title already exists (case insensitive)" do
    @product.save
    product = Product.new(title: "TEEF", description: "a", price: 10.00)
    expect(product.valid?).to be_false
  end

  it "should not be valid without a description" do
    @product.description = ""
    expect(@product).to_not be_valid
  end

  it "should not be valid without a price" do
    @product.price = nil
    expect(@product).to_not be_valid
  end

  it "should not be valid without a price greater than 0" do
    @product.price = 0
    expect(@product.valid?).to be_false
  end

  it "should only be valid with two or less decimal points" do
    @product.price = 0.123
    expect(@product.valid?).to be_false
    @product.price = 0.10
    expect(@product.valid?).to be_true
    @product.price = 0.1
    expect(@product.valid?).to be_true
    @product.price = 2
    expect(@product.valid?).to be_true
  end

  xit "should not be valid without a valid photo URL if photo exists" do
  end
end
