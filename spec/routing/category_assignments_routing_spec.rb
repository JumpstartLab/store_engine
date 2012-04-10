require "spec_helper"

describe CategoryAssignmentsController do
  describe "routing" do

    it "routes to #index" do
      get("/category_assignments").should route_to("category_assignments#index")
    end

    it "routes to #new" do
      get("/category_assignments/new").should route_to("category_assignments#new")
    end

    it "routes to #show" do
      get("/category_assignments/1").should route_to("category_assignments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/category_assignments/1/edit").should route_to("category_assignments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/category_assignments").should route_to("category_assignments#create")
    end

    it "routes to #update" do
      put("/category_assignments/1").should route_to("category_assignments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/category_assignments/1").should route_to("category_assignments#destroy", :id => "1")
    end

  end
end
