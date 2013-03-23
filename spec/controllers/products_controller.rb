require File.dirname(__FILE__) + '/../spec_helper'

describe ProductsController do
  # fixtures :all
  render_views

  describe 'GET #index' do
    it "index action should render index template" do
      get :index
      response.should render_template(:index)
    end

    it 'should load active products' do
      pending
    end
  end

  it "show action should render show template" do
    pending
    get :show, :id => Person.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    pending
    get :new
    response.should render_template(:new)
  end
end
