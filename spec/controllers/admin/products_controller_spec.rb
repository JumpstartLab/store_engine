require 'spec_helper'

describe Admin::ProductsController do
  fixtures :all
  render_views

  it "index action should render index template" do
    controller.stub(:require_admin => true)
    get :index
    response.should render_template(:index)
  end

  it "new action should render new template" do
    controller.stub(:require_admin => true)
    get :new
    response.should render_template(:new)
  end
end
