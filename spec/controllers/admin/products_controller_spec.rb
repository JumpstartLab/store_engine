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

  # it "create action should render new template when model is invalid" do
  #   Product.any_instance.stub(:valid?) { false }
  #   post :create
  #   response.should render_template(:new)
  # end

  # it "create action should redirect when model is valid" do
  #   Product.any_instance.stub(:valid?) { true }
  #   post :create
  #   response.should redirect_to(company_url(assigns[:company]))
  # end

  # it "edit action should render edit template" do
  #   get :edit, :id => Product.first
  #   response.should render_template(:edit)
  # end

  # it "update action should render edit template when model is invalid" do
  #   Product.any_instance.stub(:valid?) { false }
  #   put :update, :id => Product.first
  #   response.should render_template(:edit)
  # end

  # it "update action should redirect when model is valid" do
  #   Product.any_instance.stub(:valid?) { true }
  #   put :update, :id => Product.first
  #   response.should redirect_to(product_url(assigns[:product]))
  # end

  # it "destroy action should destroy model and redirect to index action" do
  #   product = Product.first
  #   delete :destroy, :id => product
  #   response.should redirect_to(admin_products_url)
  #   Product.exists?(product.id).should be_false
  # end
end
