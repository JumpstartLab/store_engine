require 'spec_helper'

describe Product do
  let(:product) { Product.create(:title =>"Test Title", :description => "Test Description") }

  describe ".active" do
    let(:inactive_product) { Product.create(:retired => true, :title =>"Test Title", :description => "Test Description") }

    it "does not return an inactive product" do
      Product.active.should_not include(inactive_product)
    end

    it "includes an active product" do
      Product.active.should include(product)
    end
  end
end
