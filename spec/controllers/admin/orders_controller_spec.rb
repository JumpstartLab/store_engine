require 'spec_helper'

describe Admin::OrdersController do

  it "index action should render index template" do
    controller.stub(:require_admin => true)
    get :index
    response.should render_template(:index)
  end

  it "index action should return a collection of orders" do
    controller.stub(:require_admin => true)
    user = FactoryGirl.create(:user)
    orders = [FactoryGirl.create(:order, user: user)]

    get :index
    expect(assigns(:orders)).to match_array orders
  end

end
