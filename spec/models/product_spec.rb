require File.dirname(__FILE__) + '/../spec_helper'

describe Product do
  before(:each) do
    @product = Product.new(title: "teef", description: "horse t", price: 0.19, status: 'active')
  end

  it "should be valid" do
    expect(@product).to be_valid
  end

  it "should not be valid without a title" do
    @product.title = ""
    expect(@product).to_not be_valid
  end

  it "should not be valid if title already exists" do
    @product.save
    product = Product.new(title: "teef", description: "a", price: 10.00)
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

  it "should not be valid without a status of active or retired" do
    @product.status = nil
    expect(@product).to_not be_valid
  end

  it "should not be valid without a valid photo URL if photo exists" do
    pending
  end

  describe '.gets_products(category_id)' do
    context 'when both active and retired products exist in db' do

      before(:each) do
        Product.create({category_id: 1, title: 'gum', description: 'sticky', status: 'active', price: '2.99'})
        Product.create({category_id: 2, title: 'envelope', description: 'green', status: 'active', price: '18.99'})
        Product.create({category_id: 1, title: 'cup', description: 'half-full', status: 'retired', price: '1.99'})
      end

      it 'returns all active pdts in db when no category is specified (default homepage load)' do
        products = Product.get_products()
        expect(products.count).to eq 2
      end

      it 'returns all active pdts for the specified category' do
        products = Product.get_products(1)
        expect(products.count).to eq 1
      end
    end
  end
end
