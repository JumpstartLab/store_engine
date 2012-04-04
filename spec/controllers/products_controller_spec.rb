require 'spec_helper'

describe ProductsController do
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    let(:product) do
      p = Product.create(:title => "Test Product",
        :description => "This is a test product", :price => 500,
        :image_link => "/assets/images/rails.png")
    end

    before(:each) do
      visit product_path(product)
    end

    it "is successful" do
      response.should be_success
    end
  end
end


