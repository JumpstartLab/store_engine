require 'spec_helper'
  describe 'Category' do
    it "allows a user to see the index of categories" do
      c = Fabricate(:category)
      visit categories_path
      page.should have_content c.name
    end

    it "allows a user to see a specific category" do
      c = Fabricate(:category)
      p = Fabricate(:product)
      ProductCategory.create(category_id: c.id, product_id: p.id)
      visit category_path(c)
      page.should have_content p.name
    end

  end