require 'spec_helper'

describe Order do
  let!(:order) { FactoryGirl.build(:order) }
  let!(:cart)  { FactoryGirl.create(:cart) }
  let!(:product) { FactoryGirl.build(:product) }
  

  context "#status" do
    
    it "should have pending as default status" do
      order.status.should == "pending"
    end

    it "should update to cancel if pending" do
      order.next_status.should == "cancelled"
    end
 
    it "should update to shipped if paid" do
      order.status = "paid"
      order.next_status.should == "shipped"
    end

    it "should update to returned if shipped" do
      order.status = "shipped"
      order.next_status.should == "returned"
    end
  end

  context "#total" do
    let!(:order_item) { OrderItem.create(order: order )}
    it "calculates total order price from order_items" do
      order.stub(:order_items).and_return([order_item])
      order_item.stub(:subtotal).and_return(4) 
       order.total.should == 4
    end
  end

  context "when checking out" do
    let!(:line_item) do
      line_item = LineItem.new
      line_item.cart_id = cart.id
      line_item.product = product
      line_item.quantity = 1
      line_item.save!
      line_item
    end

    describe "#add_contents_of_cart(cart, order)" do

      it "creates order_items from all line_items in cart" do
        order.add_contents_of_cart(cart, order)
        order.order_items.should_not be_empty
      end
    end
  end

  describe ".count_status(status)" do
    let!(:order) {FactoryGirl.create(:order)}
    it "returns a count of orders with specified status" do
       Order.count_status("pending").should == 1
    end
  end
end
