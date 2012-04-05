require 'spec_helper'

describe Product do
  let(:product) { FactoryGirl.create(:product) }
  let!(:product_cat_one) { FactoryGirl.create(:product_category) }
  # let!(:product_cat_two) { FactoryGirl.create(:product_category) }

  context ".categories" do
    let(:category_one) { FactoryGirl.create(:category) }
    # let(:category_two) { FactoryGirl.create(:category) }

    it "returns all the categories associated with the product" do
      #raise category_one.inspect
      # raise "#{product.new_record?}"
      puts category_one.inspect
      product.categories.should == [category_one]
      category_one.products.should == [ product ]
    end
  end
end
