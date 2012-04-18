require 'spec_helper'

describe OrdersController do
  let!(:user) { FactoryGirl.create(:user, password: "123") }
  let!(:product) { Product.create(title: "title", price: 2, description: "desc") }
  let!(:order) { FactoryGirl.create(:order) }
  let!(:order_item) { OrderItem.create(order: order, product: product, quantity: 1, price: 2) }

  before(:each) do
    order.user = user
    order.save 
  end

  describe "index" do
    it "assigns @orders to current user's orders" do
      login_user(user)
      get :index
      assigns(:orders).should include order
    end

    context "when not logged in" do
      it "redirects to login path" do
        get :index
        response.should redirect_to root_path
      end
    end
  end

end
