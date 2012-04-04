require 'spec_helper'

describe "Products Index Requests" do
  context "product" do
    let!(:product) do
      [sample = Fabricate(:product)]
    end

    before(:each) do
      visit "/products/#{product.id}"
    end

    

  end
end