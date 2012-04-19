require 'spec_helper'

describe Product do
  let(:product) { FactoryGirl.create(:product) }
  let(:category_one) { FactoryGirl.create(:category) }
  let(:category_two) { FactoryGirl.create(:category) }
  let(:categories)   { [ category_one, category_two ] }

  context "#categories" do
    before(:each) do
      categories.each do |category|
        product.add_category(category)
      end
    end

    it "returns all the categories associated with the product" do
      product.categories.count == categories.count

      categories.each do |category|
        product.categories.should include(category)
      end
    end
  end

  describe "#add_category_by_id" do
    it "adds a category to a product" do
      expect {
        product.add_category_by_id(category_one.id)
      }.to change { product.categories.count }.by(1)
    end
  end

  describe "#update_categories(id)" do
    let(:ids) { categories.map {|c| c.id} }
    it "adds cateogories when none are present" do
      expect {
        product.update_categories(ids)
      }.to change {product.categories.count}.by(2)
    end

    it "removes a category when removed the argument" do
      product.update_categories([category_one.id])
      product.categories.count.should == 1

      expect {
        product.update_categories([])
      }.to change {product.categories.count}.by(-1)
    end
  end
end
