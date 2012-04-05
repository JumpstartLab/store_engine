require 'spec_helper'

describe Product do
  let(:product) { FactoryGirl.create(:product) }

  context ".categories" do
    let(:category_one) { FactoryGirl.create(:category) }
    let(:category_two) { FactoryGirl.create(:category) }
    let(:categories)   { [ category_one, category_two ] }

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
end
