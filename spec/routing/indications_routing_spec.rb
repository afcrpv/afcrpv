require "spec_helper"

describe IndicationsController do
  describe "routing" do

    it "routes to #index" do
      get("/indications").should route_to("indications#index")
    end

    it "routes to #new" do
      get("/indications/new").should route_to("indications#new")
    end

    it "routes to #show" do
      get("/indications/1").should route_to("indications#show", :id => "1")
    end

    it "routes to #edit" do
      get("/indications/1/edit").should route_to("indications#edit", :id => "1")
    end

    it "routes to #create" do
      post("/indications").should route_to("indications#create")
    end

    it "routes to #update" do
      put("/indications/1").should route_to("indications#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/indications/1").should route_to("indications#destroy", :id => "1")
    end

  end
end
