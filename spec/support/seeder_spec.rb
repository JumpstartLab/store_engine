require 'spec_helper'

describe Seeder do
  context ".build_db" do
    before(:all) { Seeder.build_db }

    context "When database is built" do
      it "Should have at least 20 products" do
        Product.all.count.should be >= 20
      end

      it "Should have at least 5 categories" do
        Category.all.count.should be >= 5
      end

      it "Should have at least 10 sample orders" do
        Order.all.count.should be >= 10
      end
    end
  end

  context ".destroy_db" do
    before(:all) { Seeder.destroy_db }

    context "When database is destroyed" do
      it "Should remove all products" do
        Product.all.count.should be == 0
      end

      it "Should remove all categories" do
        Category.all.count.should be == 0
      end

      it "Should remove all orders" do
        Order.all.count.should be == 0
      end
    end
  end
end