require 'spec_helper'

describe Product do
  context "Class Methods" do
    let!(:products) do
      [product_one = Fabricate(:product),
       product_two = Fabricate(:product),
       product_three = Fabricate(:product)
     ]
    end
    let!(:retired) do
      [retired_one = Fabricate(:product, :retired => true),
       retired_two = Fabricate(:product, :retired => true)
      ]
    end

    describe ".active" do
      it "retuns the active products" do
        products.each do |product|
          Product.active.should include(product)
        end
      end
    end

    describe ".retired" do
      it "returns the retired products" do
        retired.each do |product|
          Product.retired.should include(product)
        end
      end
    end
  end

  context "instance methods" do
    let!(:product) {Fabricate(:product)}

    it "retires itself" do
      product.retire
      product.retired.should == true
    end
  end

end
