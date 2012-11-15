require "spec_helper"

describe CartsController do
  describe "routing" do

    it "routes to #index" do
      get("/carts").should route_to("carts#index")
    end

    it "routes to #new" do
      get("/carts/new").should route_to("carts#new")
    end

    it "routes to #show" do
      get("/carts/1").should route_to("carts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/carts/1/edit").should route_to("carts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/carts").should route_to("carts#create")
    end

    it "routes to #update" do
      put("/carts/1").should route_to("carts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/carts/1").should route_to("carts#destroy", :id => "1")
    end

  end
end
