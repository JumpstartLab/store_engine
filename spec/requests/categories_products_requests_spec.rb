describe "Products Requests", :model => :product do
  context "when I view all products" do
    let!(:category) { Fabricate(:category) }
    let!(:product) { Fabricate(:product, :title => "Foo") }
    let!(:product2) { Fabricate(:product, :title => "Bar") }


    before(:each) do
      product.categories << category
      product2.categories << category
      visit category_products_path(category)
    end

    it "shows the products" do
      find_link("Foo").visible?
      find_link("Bar").visible?
    end
  end
end