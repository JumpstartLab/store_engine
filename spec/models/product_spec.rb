require 'spec_helper'

describe Product do
  
  let!(:product) {FactoryGirl.build(:product)}
  
  let!(:line_item) do
    li = LineItem.new(product: product)
    li.quantity = 2
    li.save
    li
  end

  describe "#ensure_not_in_line_items" do
    it "returns false if a line item contains the product" do
      product.ensure_not_in_line_item.should == false
    end

    let!(:product2) {FactoryGirl.build(:product)}

    it "returns true if there are no line items for the product" do
      product2.ensure_not_in_line_item.should == true
    end
  end

  describe "#category_list" do
    
    let!(:category) do
      cat = Category.new(name: "tops")
      cat.save
      cat
    end

    let!(:category_assignment) do
      ca = CategoryAssignment.new(product: product, category: category)
      ca.save
      ca
    end

    it "displays the categories for each product" do
      product.category_list.should == "tops"
    end
  end

  describe "#retired_switch" do

    let!(:product) { FactoryGirl.build(:product, retired: true) }
    
    it "returns false when product is retired" do
      product.retired_switch.should == false
    end

    let!(:product2) { FactoryGirl.build(:product, retired: false) }

    it "returns true when product is not retired" do
      product2.retired_switch.should == true
    end
  end
end
