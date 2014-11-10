require "spec_helper"

describe AccessesController do
  describe "routing" do

    it "routes to #index" do
      get("/accesses").should route_to("accesses#index")
    end

    it "routes to #new" do
      get("/accesses/new").should route_to("accesses#new")
    end

    it "routes to #show" do
      get("/accesses/1").should route_to("accesses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/accesses/1/edit").should route_to("accesses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/accesses").should route_to("accesses#create")
    end

    it "routes to #update" do
      put("/accesses/1").should route_to("accesses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/accesses/1").should route_to("accesses#destroy", :id => "1")
    end

  end
end
