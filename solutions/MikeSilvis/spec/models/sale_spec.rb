require 'spec_helper'

describe Sale do
  let!(:sale_category) { FactoryGirl.create(:sale, :percent_off => 50) }
  let!(:sale_category2) { FactoryGirl.create(:sale, :percent_off => 70) }
  let!(:sale_product) { FactoryGirl.create(:sale, :percent_off => 30) }
  let!(:sale_product_expired) { FactoryGirl.create(:sale, :percent_off => 30, :end_at => 30.days.ago) }

  let!(:category_with_sale) { FactoryGirl.create(:category, :sale => sale_category) }
  let!(:category_with_sale2) { FactoryGirl.create(:category, :sale => sale_category2) }
  let!(:category_with_out_sale) { FactoryGirl.create(:category) }

  let!(:product_with_out_sale) { FactoryGirl.create(:product, :price_in_cents => 33322) }
  let!(:product_with_expired_sale) { FactoryGirl.create(:product, :sale => sale_product_expired, :price_in_cents => 33322, :name => "EXPIRED") }
  let!(:product_with_sale) { FactoryGirl.create(:product, :sale => sale_product, :price_in_cents => 33322) }
  let!(:product_with_category_sale) { FactoryGirl.create(:product, :price_in_cents => 33322, :categories => [category_with_sale]) }
  let!(:product_with_out_category_sale) { FactoryGirl.create(:product, :price_in_cents => 33322, :categories => [category_with_out_sale]) }
  let!(:product_with_multiple_category_sales) { FactoryGirl.create(:product, :price_in_cents => 33322, :categories => [category_with_sale, category_with_sale2] ) }
  let!(:product_with_everything) { FactoryGirl.create(:product, :sale => sale_product, :price_in_cents => 33322, :categories => [category_with_sale, category_with_sale2] ) }

  describe "Sale on Product" do
    context "When product is on sale" do
      it "Has an updated sale price" do
        product_with_sale.sale_price_in_cents.should == 23325
      end
      it "Has the original price" do
        product_with_sale.price_in_cents.should == 33322
      end
    end
    context "when product is not on sale" do
      it "Shows full price for sale_price_in_cents" do
        product_with_out_sale.sale_price_in_cents.should == 33322
      end
      it "Has the original price" do
        product_with_out_sale.price_in_cents.should == 33322
      end
    end
  end
  describe "Sale on Category" do
    context "When a category is on sale" do
      it "updates the price" do
        product_with_category_sale.sale_price_in_cents.should == 16661
      end
    end
    context "When a category is not on sale" do
      it "price remains the same" do
        product_with_out_category_sale.sale_price_in_cents.should == 33322
      end
    end
  end
  describe "Finding the best sale" do
    context "When multiple categories have multiple sales" do
      it "returns the best category sale" do
        product_with_multiple_category_sales.sale_price_in_cents.should == 9996
      end
    end
    context "When a category and a product are both on sale " do
      it "returns the best  sale" do
        product_with_everything.sale_price_in_cents.should == 9996
      end
    end
  end
  describe "A sale has an end date" do
    context "When an end date has passed" do
      it "product is no longer on sale" do
        p = Product.find_by_name("EXPIRED")
        p.sale_price_in_cents.should == 33322
      end
    end
  end
end
