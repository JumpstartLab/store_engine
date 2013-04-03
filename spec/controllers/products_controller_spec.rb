require File.dirname(__FILE__) + '/../spec_helper'

describe ProductsController do
  describe 'GET #index' do
    it "index action should render index template" do
      get :index
      response.should render_template(:index)
    end
  end

  describe 'GET #show' do
    it "show action should render show template" do
      pending
      get :show, :id => Product.first
      response.should render_template(:show)
    end
  end

  it "new action should render new template" do
    pending
    get :new
    response.should render_template(:new)
  end
end
